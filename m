Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7FFB42C3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391481AbfIPVOD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40309 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391553AbfIPVOD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:03 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so2452151iof.7
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6AarPquzkHm5tiN4Chfneb8capNztVCqvBC79jNDEI=;
        b=grQowfsuSETsBNARBvpNy4U2XSnDgoY70VvHmQL+Od+9KQqGJXh1sQVrNsQEaCt2CI
         gXynMATsSiDm4OIQSR3t2gow5BD7+i3OsXZN2r9wjd4EPfbxn4nIU/oXZr/vvhwxToVs
         KQwM1vICN/1Af93UCL3mIq6eszRAjVNAoZsThuTa+pvKp0FnFQ73KoojsyVpvkN1JFiY
         WV7MpbGlhDhdWyamGyGVxqdtuHJX5GRb5Lfai1Sn1Jo1K7JtlH9GNy89zJAK2w2w24rN
         lMfCqAUhBzQ4ZT5WVuadEXujKlI9HqeotwdwwoiIehuXH6L3K5XwW8lH96Y2p1E1wNUc
         hGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6AarPquzkHm5tiN4Chfneb8capNztVCqvBC79jNDEI=;
        b=QnVK/2DtWxeWsULArtElIOVM0FY+9y4WvNP77EkNCL2Hnv+UZTZKSGC4+xsIRjTtZu
         alDaMbyHx3iTTks4dmizjC7dxXLo8ldMXRgUnIRq+ZS3lxF5ON57eLvmKaN2qDLp5Yqy
         35F+hLn2y4+dK4xHvpBsxVFaoEDcMg1d793/xslAcuQg+RfRXMt5NKbU9H+vMtm0jAQ6
         ce25sHn8sUZbi4cYWlc6kw4Coo8eCNSziEfcSFG1g0hyry0MzH643gh4toj4sr/HWv2D
         xy4XmylPtW2Zr6Qxkacu1jz5E8qFSTOKE7ync+w1sAQ1J0sAyKVmXoewaa0pDG6/KQQ8
         P/7g==
X-Gm-Message-State: APjAAAU+ZOWHXzwHDesUkUlAj5szr2Qd2Fi7Q7DrwrPL1u1zhraFxx3r
        1aHa4jrbBAId0bNHGdPU+14=
X-Google-Smtp-Source: APXvYqx21CIM51irABO4Pik97Y01EhTNuXLIOb4/aRciDSC1KFoQt7KmqG3mdmXWV+6k7V0VQa6BJA==
X-Received: by 2002:a6b:5b0a:: with SMTP id v10mr412973ioh.80.1568668442544;
        Mon, 16 Sep 2019 14:14:02 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:02 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 07/19] NFS: for "inter" copy treat ESTALE as ENOTSUPP
Date:   Mon, 16 Sep 2019 17:13:41 -0400
Message-Id: <20190916211353.18802-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the client sends an "inter" copy to the destination server but
it only supports "intra" copy, it can return ESTALE (since it
doesn't know anything about the file handle from the other server
and does not recognize the special case of "inter" copy). Translate
this error as ENOTSUPP and also send OFFLOAD_CANCEL to the source
server so that it can clean up state.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index bbf7c1e..f8ebd77 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -393,6 +393,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			args.sync = true;
 			dst_exception.retry = 1;
 			continue;
+		} else if (err == -ESTALE &&
+				!nfs42_files_from_same_server(src, dst)) {
+			nfs42_do_offload_cancel_async(src, &args.src_stateid);
+			err = -EOPNOTSUPP;
+			break;
 		}
 
 		err2 = nfs4_handle_exception(server, err, &src_exception);
-- 
1.8.3.1

