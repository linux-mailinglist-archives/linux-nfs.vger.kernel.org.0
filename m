Return-Path: <linux-nfs+bounces-14844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB7BB1883
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 20:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317FD1624FA
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72524C676;
	Wed,  1 Oct 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV7g4Ypi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E71898F2
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344458; cv=none; b=mPOXEyZIq0L1PLR9RiWRo81/wjOXMLTNOnjT7C4rDdCNKFHrf+i50r+9u+XJG66hqBDldTz8WnAWXCW/HfjLagjrCSIlITC0o4cGcx14SoZnCfXfNzg8AJDhqTHhD9z05TILyjqh0ks0nEyDq5OplpA9TuGRHBV0ieMqdvQFezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344458; c=relaxed/simple;
	bh=2ELeqdSLMQsbzyNHdyiVPMj9HSROiiHXmvtTpgQ5k9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvXCI5kYLyRu0axN9gvmFTRdTGs9TDiGCIiXmxg9Rbnr7iPlknEsYXlWISANH5Qpk3mlPQbhM2bvuG22tetcsM0r1tesr9uO4hkUp07jN7/K3ZOLKeJH3zZOBVrwF8bhC8J+uJV/G0J32uweN1e2bJlthvCzISUpXKy63DF7jsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VV7g4Ypi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759344455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw4o971GBvag3r8RG2OV5y+taQ29VjiJKa3hxyQS+O8=;
	b=VV7g4Ypiu/ghWn43W3anfOHeNbvGHDcOrDiJTND6b6Sqaegu6s+HH45XGMZrzGH4WSqZUm
	V2eeL+4nos60IzfHEzLp1CO/woRi/cXbe26xb6NnwpEh/RnmMJuajNLg3j90ZMbugh3Pbm
	Kdme0Uy74CZNh4pllRRaICBO6Tvj7SU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-KnX80Ol-MGCVzwndoNjZ5w-1; Wed,
 01 Oct 2025 14:47:31 -0400
X-MC-Unique: KnX80Ol-MGCVzwndoNjZ5w-1
X-Mimecast-MFC-AGG-ID: KnX80Ol-MGCVzwndoNjZ5w_1759344450
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD9BF19774DF;
	Wed,  1 Oct 2025 18:47:30 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 549F31800577;
	Wed,  1 Oct 2025 18:47:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: =?utf-8?q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] nfsv4: Add support for the birth time attribute
Date: Wed, 01 Oct 2025 14:47:28 -0400
Message-ID: <E0D9CF60-9BC4-4C04-A28F-844296EC61D5@redhat.com>
In-Reply-To: <CA+1jF5pWue5xoRWWecTa95Fuk-qTtBCsTSrVqp6D=_6YSO8+rw@mail.gmail.com>
References: <20230901083421.2139-1-chenhx.fnst@fujitsu.com>
 <3461ADBE-EAD4-4EEF-B7B0-45348BCDB92C@redhat.com>
 <CA+1jF5pHpXHMOv_gRf_en2uX9jfwcCNhoDhYoq5butAFiiMsxg@mail.gmail.com>
 <CA+1jF5pWue5xoRWWecTa95Fuk-qTtBCsTSrVqp6D=_6YSO8+rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 1 Oct 2025, at 11:42, Aurélien Couderc wrote:

> What is the status of this patch? did it ever made it into the Linus
> mainline kernel?

Hi Aurélien,

It turns out that there was already posted (much earlier) work to implement
btime in the NFS client.  That work was refreshed:
https://lore.kernel.org/linux-nfs/cover.1748515333.git.bcodding@redhat.com/

and has been accepted into v6.17.

Ben


