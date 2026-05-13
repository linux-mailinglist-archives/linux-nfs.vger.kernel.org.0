Return-Path: <linux-nfs+bounces-21607-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB8PBD7cBGrYPwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21607-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 22:17:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D153A664
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C2BD3012EB0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF223A9DAB;
	Wed, 13 May 2026 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3jTwcn7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42B3A4F5E
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703418; cv=none; b=nGcqi2sR0/i/y52aZ0sf3fPGEHcwISecVtk4uqiNE2dH6CYyGYYCjeon8mrY5Lh6EudTK7wCbKMD3TrFVPawaYEzyLEUNS1qb+kv11iVBG+aiHOvGMrV42s+c6smkxvXzuRsMBv0zw4iwA30ex89vIxlQ0a5gYa+drgfubR4lOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703418; c=relaxed/simple;
	bh=GJKD3Dd7idpMyczr0fWgC3EMCWM4ywg9m3HKwYagIH8=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=uAklK/tPCKhCCC2vmg2lJ8Za/AkHmxTazREoYyL1XRMtKzZ785Bmv+D15JH1avHYWRpShEBiyXMZjYpEDxmTVX8XFsJzJpvxGs3MYcYXwnOvhc6IuCwvlI5NbaJazCvX7E5akwCkxGiR498C82dI16E4f38AO/0i/NQTfi0tLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3jTwcn7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778703416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmxfjKyS9fuAJVxLQAwUjqnNHQEjnWz1KrW4T6ZbphY=;
	b=d3jTwcn7PP7B+V0B01vD3s9hzbEbo36nJ393XEGlFrvzyIJOaiIurtDWPJZIzZVOUUC3Fz
	9Va2rtkvXUaBx3uey+JNr6KbJmUSrxzbIs4muiwH7MEO/E0Z9DKLv22m7os60TAb90uppA
	6Nl6A83WJUI3cPqoP07KLsHz3rq9nWU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-of0K6lSLO6yTTFK94msuhw-1; Wed,
 13 May 2026 16:16:53 -0400
X-MC-Unique: of0K6lSLO6yTTFK94msuhw-1
X-Mimecast-MFC-AGG-ID: of0K6lSLO6yTTFK94msuhw_1778703410
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADC6219560B7;
	Wed, 13 May 2026 20:16:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 837701800576;
	Wed, 13 May 2026 20:16:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260513131941.1439155-3-dhowells@redhat.com>
References: <20260513131941.1439155-3-dhowells@redhat.com> <20260513131941.1439155-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Hyunwoo Kim <imv4bel@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David
 S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
    linux-crypto@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1969092.1778703403.1@warthog.procyon.org.uk>
Date: Wed, 13 May 2026 21:16:43 +0100
Message-ID: <1969093.1778703403@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 504D153A664
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,gondor.apana.org.au,oracle.com];
	TAGGED_FROM(0.00)[bounces-21607-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Action: no action

David Howells <dhowells@redhat.com> wrote:

> +	if (crypto_krb5_check_data_len(gk->krb5, KRB5_ENCRYPT_MODE,
> +				       len, sizeof(*hdr)) < 0)

This should be sizeof(hdr) here in patch 2 and sizeof(*hdr) in patch 3.

David


