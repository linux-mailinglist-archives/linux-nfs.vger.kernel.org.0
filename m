Return-Path: <linux-nfs+bounces-11162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51934A9204A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E217019E7ED8
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F48347B4;
	Thu, 17 Apr 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbazUo3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE21C5D61
	for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901634; cv=none; b=Cs/CF6sz8xPqLAYjJexTVJ6dPsXeLXbtec4EFTgdborYhsdEclRNw14w9AZmrw+5YzikXawW6UzSYAN0lMEY4m2/nCV9ifwlniHbEkcO89NJcg+naCrJfblQgKkkAo4oLn+R8wjV72/AVpGrpDBvDz+2my8m3pPrTizcMVFHt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901634; c=relaxed/simple;
	bh=0Iqn/IHnf9qcxpO1rTlmD2iFJm32eIT/CJopXLEO9P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ald3PNXBXuqRVySkHDX4gmYJheUmX6g4crGoJ0jX2KRybgHO18vNZZj9fSyp6P4PgrS3elHaCFYvI7NMuQywbAS/8VD6VV0dXJwcVtqtg1om60rRlsF9sPTTAH2q0l7+WDRN55LQR5Nofv1j/ivsxu+UwtJChIGLOAuP14l+0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbazUo3p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744901631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOiqWgtpgSzfOG2pkLHUccW6YTEaDhMkyF2lfqqU3pY=;
	b=hbazUo3pe5rklCrd3n2ZdjHV7q/CLasrdgNtb9nWtPWAa4Zy2BfbnGDYQQzhto0Mi1d+kw
	HCy37c98Wzk7V0YsvLXnUZSEUEti5JrjUUMn55IrAP5ooQneKtf1dZHHeE3OlV4BLIwbuG
	BdAEkU+U7CErvC1fMPwAFpFesqNHlAE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-l2J7V7eBOzSp3img5l7Agg-1; Thu,
 17 Apr 2025 10:53:50 -0400
X-MC-Unique: l2J7V7eBOzSp3img5l7Agg-1
X-Mimecast-MFC-AGG-ID: l2J7V7eBOzSp3img5l7Agg_1744901629
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93795180087B;
	Thu, 17 Apr 2025 14:53:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBAB019560A3;
	Thu, 17 Apr 2025 14:53:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Wanted: more fixups for client delegations test/free walk
Date: Thu, 17 Apr 2025 10:53:46 -0400
Message-ID: <E98565A9-5F18-4775-A49D-8428FCA06F92@redhat.com>
In-Reply-To: <abb530ae3de183aa5839222757b36f186c68d65a.camel@kernel.org>
References: <9146009C-5726-400D-8571-504F5B36C651@redhat.com>
 <387a5701d884538aa36a35d186d03f3e4123ffbc.camel@kernel.org>
 <2CD51D9C-D481-463B-851D-195B10C1F1CD@redhat.com>
 <abb530ae3de183aa5839222757b36f186c68d65a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 17 Apr 2025, at 10:46, Trond Myklebust wrote:

> Why should we be changing the client if the server implementation or
> the admins are abusing the functionality? Revoking delegation state
> should be an exceptional case because it breaks locks and therefore has
> serious potential to corrupt data.

Clients might not have control over what servers do, and keeping memory
reserved for objects that will never be used again creates both a resource
and performance problem for the client.  This is a problem even for the
exceptional case.

> We can definitely have a separate list on which we put the state that
> fails the FREE_STATEID test.

Is there a reason (I'm not understanding) why we can't remove delegations
from the nfs_server->delegations list after a successful FREE_STATEID?

Ben


