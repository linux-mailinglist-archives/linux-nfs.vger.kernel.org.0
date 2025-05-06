Return-Path: <linux-nfs+bounces-11524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C325FAAC880
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98EF1C4383E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524A2820B8;
	Tue,  6 May 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N9NeQNTe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF828135A;
	Tue,  6 May 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542805; cv=none; b=EF7O/ixIiSHqtpFVNmB4mTLBJUaGY/Y3I+U28uAKxQAGwuOm92gFx3Obac+bAH8XMbDyGCRMCaHYdLFOzA7oTrdq9j3Zn01qxmWCh669fmMOK4sIA6hcb9InLe09++xWWqm4irj67v3d/JW+/loXklrif2LGL1/dTpTO77ShcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542805; c=relaxed/simple;
	bh=4VauHsP8Ch+LgmiM02IAI/jXrGgvF0WZSu8n38ivKn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYQ8udpCsOZOAQNXa8Kkvc42Jr67MNAg3skJkoYNJ5pKwH1QJzeJWVUxOOodRtN/KLop3o5PG2Ba0cxy4kOAhEHlLHha8gDDPa7iBICgvnYt2pyb1k8wZto1ZsRjsMnPklpWYzr01RKewSEqrPKnLvPYJXzosPewY7pIvKx4tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N9NeQNTe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jJsNGbaefMw7bdsKH+G12242Nnl3+FvdB8oePEJLJb4=; b=N9NeQNTeGGxf0szqgtCeR/Jdi0
	3wA2Hpvvcg95IpEVAzHIXv3ryZVQxz8drLoR+P9yyYtfjemmo9rwBThi6AvyH8OfiYgS/p6qlf2zV
	hnz8rL9qO+RXN6WQPV7YATzJT9H3ZLYaRx91w9ZesuhDj2nRA1M5n798T2nkfdWpkG3uMcYEsxT97
	Am36NfeHtVrmal9zcrQPBvuEl/9VzvYX5rikwqvCLDuS71xc2G54qeX1NZ44UbEaRRLc89tAHnGNI
	SAOLuohmQfyR3bDRyO31Q81ocgTrSLfzAjtWtOqNWCiw4+cS+22hdShVd7N0MbHr7xbDt5AxqCg7E
	XVc3V/8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJZD-0000000CNRm-1zQA;
	Tue, 06 May 2025 14:46:43 +0000
Date: Tue, 6 May 2025 07:46:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBog09quIh39IL3W@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 03:03:10PM +0200, Hannes Reinecke wrote:
> Hmm. We do that already:
> 
>         dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>                 qid, pskid);
>         memset(&args, 0, sizeof(args));
>         args.ta_sock = queue->sock;
>         args.ta_done = nvme_tcp_tls_done;
>         args.ta_data = queue;
>         args.ta_my_peerids[0] = pskid;
>         args.ta_num_peerids = 1;
>         if (nctrl->opts->keyring)
>                 keyring = key_serial(nctrl->opts->keyring);
>         args.ta_keyring = keyring;
>         args.ta_timeout_ms = tls_handshake_timeout * 1000;
>         queue->tls_err = -EOPNOTSUPP;
>         init_completion(&queue->tls_complete);
>         ret = tls_client_hello_psk(&args, GFP_KERNEL);
> 
> ... but we never evaluate the 'keyring' parameter from tlshd.
> Should be easy enough to fix.

That is only used to link the keyrind in tls_handshake_private_keyring
and never passed over netlink.


