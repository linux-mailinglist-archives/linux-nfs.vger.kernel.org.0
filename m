Return-Path: <linux-nfs+bounces-20938-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLPxBNlF4mlh4AAAu9opvQ
	(envelope-from <linux-nfs+bounces-20938-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 16:38:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8141C23A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 798C93138ECB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33833B582F;
	Fri, 17 Apr 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAVDp8Kj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130B3B47C0
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436288; cv=none; b=S7eoCUl0uEdGJicnTRwPQmG4qV1nxUxzPy9VwR9cpgrSLg7jBRFxCxwHPW/APzmTAOqDNmEvBvEZDkIA+mqtviWIhdRdLhbKskCZojkN1Wf3mb3yyIJdp1aisP0BKB8dAenI37QOxyyibiWsLA6W7MZ8dcLHeZB+PjBu7nS7Jto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436288; c=relaxed/simple;
	bh=/jvh9KPO3EUDUN5JkbXDVglEQoDRIHijpyCh5swvEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF858vtS+1ZMIleyBWkJsXuerjaT8JyRscrHHXh+OKcuXAyleh+fNeBaldnWRX9jQW3hgocrqFgclTobTt/6E29AhUL1/w7af8LwW1KxzqmdqeIqQ5bxPNTqrlslEP/Yz5KGiat8jd3WQRFnCyYw8Mrlj4xxFs4Yy/HgfVBg024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAVDp8Kj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776436285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GEZDE8GZxKpOoTtyKx28XlgtTosah4Bsd5EpMwehZg=;
	b=NAVDp8KjnXYKeU6YqkiBtdX8951snWc4V8R+g4R3dx6QpWsbLP9+p4SoB5LfMcUPtyZ8mz
	HcLQsWxgVOBF0oYBeuXJXRdQjCiFQDdxwuh1zIZ37+xrA3Q+U6OKamdfw+Wt4+iP0O4uRk
	8FFqoR1gd+ykLhf53ZtsK3i3vUqeSXY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-4PqsSOhSMOeMeV8DcRfqug-1; Fri,
 17 Apr 2026 10:31:19 -0400
X-MC-Unique: 4PqsSOhSMOeMeV8DcRfqug-1
X-Mimecast-MFC-AGG-ID: 4PqsSOhSMOeMeV8DcRfqug_1776436278
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EAFC1800370;
	Fri, 17 Apr 2026 14:31:18 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.81.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C807130001A5;
	Fri, 17 Apr 2026 14:31:17 +0000 (UTC)
Received: by smayhew-thinkpadp1gen4i.remote.csb (Postfix, from userid 13752)
	id 2C35045E0497; Thu, 16 Apr 2026 20:40:10 -0400 (EDT)
Date: Thu, 16 Apr 2026 20:40:10 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH pynfs v2 07/25] server41tests: test rename triggers dir
 delegation recall
Message-ID: <aeGBaphClApyoGE6@smayhew-thinkpadp1gen4i.remote.csb>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
 <20260416-dir-deleg-v2-7-fad510db5941@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-dir-deleg-v2-7-fad510db5941@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20938-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smayhew-thinkpadp1gen4i.remote.csb:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7EE8141C23A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026, Jeff Layton wrote:

> Get a dir delegation with no notification mask, create a file, then
> rename it from a second client. Verify that the server issues a
> CB_RECALL.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  nfs4.1/server41tests/st_dir_deleg.py | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
> index f5265e8cf0ab..d8d09cd4bf7e 100644
> --- a/nfs4.1/server41tests/st_dir_deleg.py
> +++ b/nfs4.1/server41tests/st_dir_deleg.py
> @@ -175,3 +175,36 @@ def testDirDelegRemoveRecall(t, env):
>      ops = [ op.putfh(fh), op.delegreturn(deleg) ]
>      res = sess1.compound(ops)
>      check(res)
> +
> +def testDirDelegRenameRecall(t, env):
> +    """Verify rename triggers dir delegation recall
> +
> +    FLAGS: dirdeleg all
> +    CODE: DIRDELEG4
> +    """
> +    c = env.c1
> +    recall = threading.Event()
> +    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
> +
> +    # Create a file from sess1
> +    claim = open_claim4(CLAIM_NULL, env.testname(t))
> +    owner = open_owner4(0, b"owner")
> +    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
> +    open_op = [ op.putfh(fh), op.open(0,
> +                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
> +                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
> +    res = sess1.compound(open_op)
> +    check(res)

You probably want to close this file at the end of the test so you're
not leaving state behind on the server.

-Scott
> +
> +    # Rename the file from sess2 -- should trigger recall
> +    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
> +    rename_op = [ op.putfh(fh), op.savefh(),
> +                  op.putfh(fh),
> +                  op.rename(env.testname(t), b"%s_2" % env.testname(t)) ]
> +    slot = sess2.compound_async(rename_op)
> +    completed = recall.wait(2)
> +    env.sleep(.1)
> +
> +    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
> +    res = sess1.compound(ops)
> +    check(res)
> 
> -- 
> 2.53.0
> 
> 


