Return-Path: <linux-nfs+bounces-7277-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B839A3FC7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65641C20E3E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007259476;
	Fri, 18 Oct 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTqsrelk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175EE20E335
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258459; cv=none; b=Vxi2vGs3weLUKvO/Mg21hFNDFVjjN/0OjOO4jhs60ox6QnhaJYuCEbMg0wdr/Xc+bgpHqVHxgMn11nS+yosdKKCY/kPcxXPSdWUY+ubU/aQf8LyE68/0LYB4paZ4ikUe8K9ahgtALATMhTeuXbbNv2jbRq8q7GAPQBDQoqk5GvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258459; c=relaxed/simple;
	bh=KfrzCyefy649irmmq/qZ+DUFXAIPz6l1s4+tFDtEsmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S60QuPvXrqAfZQD9ULroRCcPi0SgJGGinv1qW7aphlgZPS8xvuQPdb8i8Ux4sLcoQMai0Ne4/mDCPeaL0Z5FpPkB6KIbw3cm1j70N0Crm1TtkBj3mlbNTU+N9nHV2MiATrl/FDGbWReqM3ua0LYzyfSA5O8yeZji3B69FRBzk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTqsrelk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729258456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfrzCyefy649irmmq/qZ+DUFXAIPz6l1s4+tFDtEsmg=;
	b=VTqsrelkiBoswWxnGMqJI6YBaxpOceTM2IK5rovnn/+3JPFHcjhabgcYrqlTWrJP/1qy/v
	pmMYsbJXLDrTtLm64iRBK+oWHFLvtYdacDN5idhESDFgZTgGyDpbUmNF0E2uM40ofPXiZF
	iEuAgp4AtYt5JpiIRmFUnVOyfggiKdk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-fE7pwilsNYiN4pTxWmEN0w-1; Fri,
 18 Oct 2024 09:34:13 -0400
X-MC-Unique: fE7pwilsNYiN4pTxWmEN0w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E51819560AB;
	Fri, 18 Oct 2024 13:34:12 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6931956086;
	Fri, 18 Oct 2024 13:34:11 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: Re: /etc/exports refer= syntax for raw IPv6 addresse?
Date: Fri, 18 Oct 2024 09:34:09 -0400
Message-ID: <DCF652DE-43AF-46B1-A9A0-CF2B488A49BE@redhat.com>
In-Reply-To: <CALXu0UdkaXPMWEe9amJ5Ugg0rw3CWnQMLDyhx6PtPc6oEKoPMg@mail.gmail.com>
References: <CALXu0UdkaXPMWEe9amJ5Ugg0rw3CWnQMLDyhx6PtPc6oEKoPMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 18 Oct 2024, at 9:06, Cedric Blancher wrote:

> Good afternoon!
>
> What is the /etc/exports refer= syntax to pass a raw IPv6 address?
>
> PS: No, nfsref is of no use, the target system does not support it. I
> need the refer= syntax for exports(5)


I believe we expect the use of '[' and ']' like this:

refer=[fd7a:115c:a1e0::36]

Ben


