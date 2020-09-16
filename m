Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84126CEB0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgIPWXm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIPWXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E71C0698C5
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:45 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so10035992ioa.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SEdv98P4dQK4v8q+wkvO0PirXXKU/LDrQFCsi8Hrx4U=;
        b=OAfX81Ovi3zeshRSSgEMw9GcwFGBERx4+fD1R0dwEMIphpv8ZaJ10dIykMSd8XwCl1
         QkwwPVjO5SQWyiyhpmI3DAb1oAFqNMfr9nrkiqhBZ6f/GmyroH6mli5r8HXeMu8G7YIP
         ELY+g8ABveqqNuYNDq0eR7lx86h+qySuxhnR8AVd5QxL+u7rKJL/kiGT8srcGXS5G3K/
         AYW7Cfk6x3uE8p2GzaDo+PU4+Chlm3uI8iGasaY2GZerr8T0sbnH9dHcenrU5qQ4qT0S
         j2O+jJKEiKQdBprNmnc3ENJ+WHbBtAmescV+veJYuQyClY+BK8BRDa0dnLud7pkRdJsF
         7pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SEdv98P4dQK4v8q+wkvO0PirXXKU/LDrQFCsi8Hrx4U=;
        b=ZLpRCw/eq0Mqj4N/Eij6mUQzWd5q2HCgS5zFjdqdE359CI/twN1vLGLgdDsxCMewqW
         RulONWt8cbo9+7Rh35NUF012cDV5EzcjxwRh/mjj0nIyQeHKSdgoaT7TOYwukf+yHm0w
         fqSGtG+kSP9b/ZuN4PDFMX1jtWqrp9gySo+O4u5nOjEzDSl2aLzV1zX7ZhDFX3fpGJ97
         s/qZaVD8WvMTSQS468P/6GLcWqttyI84uzI799fftWbFZ12yb6RCmtcwUnnWWb+9AqZ/
         1AXwvFqiTDx+cgUpdJtOrnR8VfTWalw2/AzBQVJY6OnQKNu2r5gFUD+xXNMEtRw1BPnp
         wLiw==
X-Gm-Message-State: AOAM532TdLWI/S80syFmWOVf+NMcr0hHURZaur6t01pSJVsxZf+r5cMm
        ysEuuVTpa3B7ITqAfUJTvUvDkRa2iYQ=
X-Google-Smtp-Source: ABdhPJzCBPBnz3GzVbzL20AY3rPTxTcpvseaLafACRnv4PehSLWM78F9NZrVaUHdR/boPmB5ynwU8w==
X-Received: by 2002:a5e:9916:: with SMTP id t22mr20922646ioj.163.1600292624546;
        Wed, 16 Sep 2020 14:43:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h184sm9746225ioa.34.2020.09.16.14.43.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:43 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhgoQ023029;
        Wed, 16 Sep 2020 21:43:42 GMT
Subject: [PATCH RFC 17/21] NFSD: Add a tracepoint for DELEGRETURN
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:42 -0400
Message-ID: <160029262289.29208.7879301642908653952.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the stateid being returned to help troubleshoot problems
with delegation. The status code is reported by the
nfsd_compound_status tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    2 ++
 fs/nfsd/trace.h     |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6509e431ddd2..8444e8b51fa8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6302,6 +6302,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
+	trace_nfsd4_delegreturn(rqstp, stateid);
+
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index cf350f37ddc9..2e4697324aa8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -510,6 +510,32 @@ TRACE_EVENT(nfsd4_stateid_prep,
 	)
 );
 
+TRACE_EVENT(nfsd4_delegreturn,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const stateid_t *stp
+	),
+	TP_ARGS(rqstp, stp),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+	),
+	TP_printk("xid=0x%08x client %08x:%08x stateid %08x:%08x",
+		__entry->xid, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
 	TP_ARGS(stp),


