Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7F2731AC
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgIUSMn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUSMn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC0C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:43 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so14672331ilh.8
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JPKyUsBvyfjtug/Y6o6hLHKjY0O/mXYvD0xzKHaJOZM=;
        b=O4YGBTvTpkzU01tT09voWQ5rUIA/jumYElT0Ncz2VO9X7mouqy1Vpr80sMcRG8jBay
         vV2GmWbDinA/aZn1y8e/hBz8xppDs9/EDEduYE7q/JAh4E6Ry97e5G8YV6uGXasU1iht
         L3/86BOp5RrZFmafB0ebzG95mnGxtgWAYc9C5ViCMhf/ZRJXvgX50NHdzD/ESOqNgx6j
         VgGguMLzrAzH/5J9tblXEXoEGYrhzEDkOge3szy25hs83kXzf0H5i+/nJcQahgPbtjCL
         nZdOu064jrS7uJvhDWdkbWHpBc0PZ02PXUkia2K0kAnIyHBCiOGJdHDRiaZadEtpcKxW
         OHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JPKyUsBvyfjtug/Y6o6hLHKjY0O/mXYvD0xzKHaJOZM=;
        b=PUkX7/iD5V5SgahRqd/FRjRRLMEzSOQblMUL8jI/T8TJknh0fvaF5rzgjJJf51c6wh
         9LMEBztjWw2sTLOTRWZEd8/M8crmm3jnV4V7Gd20LalQhZCpMcfBp4+IYHtbA0G937Tb
         NY5TQjxr4DHR6RQ/cAj3UVD554p4poMIo2EEfPYXnFI4PROX7/LNONYUrhNUHUNW30sx
         m80pa6WbBw88MqBmB55GJKb9XJp/Mcm5CQ34/ai4BnnTi+jsHDnpFwT+nmnkAmfsYY/z
         P7ihXGmwigX2heOgJObZFIq2DTNvW/D7D73SSiSBc0a02G4Trlr+7LsUhEHFJ2jVXPpS
         CLyg==
X-Gm-Message-State: AOAM531Gcf6aE3wCKuhxulX2JlA3paPGGWyCNSAq7vddY4WafxfulE+L
        G/0mcq0Rwg012Bgrrzhmc8zlyiQO9Ok=
X-Google-Smtp-Source: ABdhPJyP2aSfzcNzA2KNE/WKs3rxPWsxasDrnp3THCYJ5uDh+SWJz4ntSE0dLxAtSp1JsSA9QTe6fg==
X-Received: by 2002:a92:6b0b:: with SMTP id g11mr986158ilc.62.1600711962444;
        Mon, 21 Sep 2020 11:12:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z72sm6061158iof.29.2020.09.21.11.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:41 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICeeu003905;
        Mon, 21 Sep 2020 18:12:40 GMT
Subject: [PATCH v2 21/27] NFSD: Add a tracepoint for DELEGRETURN
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:40 -0400
Message-ID: <160071196084.1468.5289482843533388498.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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

nfsd-1035  [002]    75.873544: nfsd4_delegreturn:    xid=0x6575fc16 client 5f68de0f:f04d8b16 stateid 0000005c:00000001
nfsd-1035  [002]    75.873574: nfsd_file_put:        hash=0xac7 inode=0xffff8887050d7470 ref=1 flags=REFERENCED may=READ file=0xffff888717a79680
nfsd-1035  [002]    75.873575: nfsd_file_put_final:  hash=0xac7 inode=0xffff8887050d7470 ref=0 flags=REFERENCED may=READ file=0xffff888717a79680
nfsd-1035  [002]    75.873601: nfsd4_compoundstatus: xid=0x6575fc16 op=4/4 OP_DELEGRETURN status=OK

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    2 ++
 fs/nfsd/trace.h     |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 47790c7a29a3..992ac867e52e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6303,6 +6303,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
+	trace_nfsd4_delegreturn(rqstp, stateid);
+
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 18b359a04d96..234b4ea7a4c7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -679,6 +679,32 @@ TRACE_EVENT(nfsd4_stateid_prep,
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


