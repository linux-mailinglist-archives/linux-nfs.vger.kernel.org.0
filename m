Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1A496C69
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 13:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiAVMt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 07:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiAVMt5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 07:49:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B413AC06173B
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 04:49:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso21192294wmf.1
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 04:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A8K9vZxridMOkLbq07LHkl+Eeb7HVIR537LcYty9DU=;
        b=D9ELU+qJcBuhJhy7i3UPxpcmtgKpaaanW6xBFof5tkrwvAjryJHoB5L+bbGL4y+gto
         ySoNTOt8ODiVFotua/ST+C8GOR4KTLlhtvOsufTnirTdtEe19Q4UKsTH14JMrw9ABmyC
         NfXqYud40imwDUcc2fNvFVtuIF57hlajir8MfiMgamIOLz+nGQvmrGmCy/Ya6T+uFsQF
         xvy5rn150xvqlNRKJqpjGyevY8teG+R6cYePefS8U1VjcMnq3imDtEM88nLIrnbV/mcr
         Y6y6WnKDklhq0ZvHKSmXzP0no8sOeXf+o5Bi8x5Wza23IwVIZINr0S3Kt4k/iESZtPh8
         yemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A8K9vZxridMOkLbq07LHkl+Eeb7HVIR537LcYty9DU=;
        b=6hT2Fp7dWBmqk54CC4zl5engeO0PH9Zi+coC9kZfQVkzWrTM8v+kOMBAeee/Ele/BT
         OHNcklbF5+fMvOfLhntkaV/NVda1y+hzYcwqEE/VeupY4MGf6htvRaxa3epWPB3jcdaw
         qC1tw2Rc98B/38PhqdSxRg0mwM2HIxBX7NTcroMpuHP/yJ0ssknlzcJlnnFCGa9wnWjB
         u+kui0INRxYV0s2ZFrReR/6jRWV+EI8tuzv8g4SbqDDqZ/8R2cwrokSiaKq0xmQJicru
         djA8r1yfxAGgs0Xa6+b29nRcD4+PwHqknXZT2obdcdIkzZMI6I0ByKISqjy++ZwtN5ES
         Dylw==
X-Gm-Message-State: AOAM530bFiIrsicttCcSXnFv61bCfh7zWrbHLfXLlqg1QWDaAHoJZhyN
        Y9M9RwBGemHCq/PwbH/H/ZKzsT8CVqWp9A==
X-Google-Smtp-Source: ABdhPJwRPzVSZhCHEMWiQ8Mcc6PNMBkZWnetbaMBA+Wu+SsVpMNwYZtHRchhfAvxN80y46DbKjb2Vg==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr4399024wmb.73.1642855795285;
        Sat, 22 Jan 2022 04:49:55 -0800 (PST)
Received: from jupiter.lan ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id a15sm8576130wrp.41.2022.01.22.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 04:49:54 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     chuck.lever@oracle.com
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3 check
Date:   Sat, 22 Jan 2022 14:49:53 +0200
Message-Id: <20220122124953.1606281-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
References: <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Due to change in client 8cfb9015280d ("NFS: Always provide aligned
buffers to the RPC read layers"), a read of 0xfff is aligned up to
server rsize of 0x0fff.

As a result, in a test where the server has a file of size
0x7fffffffffffffff, and the client tries to read from the offset
0x7ffffffffffff000, the read causes loff_t overflow in the server and it
returns an NFS code of EINVAL to the client. The client as a result
indefinitely retries the request.

This fixes the issue at server side by trimming reads past
NFS_OFFSET_MAX. It also adds a missing check for out of bound offset
in NFSv3.

Fixes: 8cfb9015280d ("NFS: Always provide aligned buffers to the RPC read layers")
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfsd/nfs4proc.c |  3 +++
 fs/nfsd/vfs.c      | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..3b1e395a93b6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -788,6 +788,9 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
 			      read->rd_offset, read->rd_length);
 
+	if (unlikely(read->rd_offset + read->rd_length > NFS_OFFSET_MAX))
+		read->rd_length = NFS_OFFSET_MAX - read->rd_offset;
+
 	/*
 	 * If we do a zero copy read, then a client will see read data
 	 * that reflects the state of the file *after* performing the
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 738d564ca4ce..4a209f807466 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1046,6 +1046,16 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 err;
 
 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
+
+	if (unlikely(offset > NFS_OFFSET_MAX)) {
+		/* We can return this according to Section 3.3.6 */
+		err = nfserr_inval;
+		goto error;
+	}
+
+	if (unlikely(offset + *count > NFS_OFFSET_MAX))
+		*count = NFS_OFFSET_MAX - offset;
+
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
@@ -1058,6 +1068,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_file_put(nf);
 
+error:
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
 
 	return err;
-- 
2.23.0

