Return-Path: <linux-nfs+bounces-11893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDEEAC2F82
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB68A209EA
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADE81E501C;
	Sat, 24 May 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="GSdqruRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95031E3772
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748087364; cv=none; b=sVHqAu57nkrXhDbaXdVxQRL0KAc8j65x8t56INEanuRCdr7EiWsozNKSeFY3OkU77j3jkbuhIXJJv7dvCQYTTAfofXZ4COuwU4O8bvU1Nbd1OIeruhOoi6gx1eWFmmxkLXJkaSCCj5pEOMTBAgV+qEDRmvegzWHJBmjKbjIzbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748087364; c=relaxed/simple;
	bh=kNDOoT5a2pYSYCdwEX1pCbotOS/BB3aXrGBCczpgmBc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=tu3hWPxak7nVEp1ozrPmaISuUYVb5vr5hMVJwnmlGYE4v4iyVsBBa/DJ1YaY4Q+VSv/Ff1nT+aVbWYLdKvAyEjYxLyaW/g3JCHLHhZaBnikr3xzW0Yq5zk0M0FZRBJparadss6SaoViBSMxIeP68JvF6SizuB/Jj8wJ4HsWYEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=GSdqruRq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DFA50240027
	for <linux-nfs@vger.kernel.org>; Sat, 24 May 2025 13:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1748086911; bh=kNDOoT5a2pYSYCdwEX1pCbotOS/BB3aXrGBCczpgmBc=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:To:Subject:From:From;
	b=GSdqruRqvN07b40LsTubpOmRh9Vc4TseXZY9PRzHojY7gEPhUKnkOFmM1yW1ZPX2i
	 V+U1GtX6GeFHYYi1VCsxA82cvw7vC4obiMyvuSYuSMYWV9N0eYE0JJrrZ5em8/s9TW
	 quav+CR2ocIKAiBu/caTTTf6BtKLX2sElQTDwN3lEE/j0TzF1rGLXPV4GD5IiFTQMJ
	 iRJMbKbCkM6ztqvYEbalT6U6Lj81Rg+qqHHhKlfABcAdsMsyGs+7gTPMdkgA8zkAC2
	 ZlNLG12JZU3RUap2t+dI2d/Zh6lE/WOaiogTILGfjLxVE+kL2/zf17n7xL7sbwFwQk
	 8sc4l6fQjASQg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4b4Kqz3qvgz9rxL;
	Sat, 24 May 2025 13:41:51 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 May 2025 11:41:51 +0000
Message-Id: <DA4D3CP4XQDK.1DGSBGV7A4JMO@posteo.net>
To: "Sertonix" <sertonix@posteo.net>, <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] autoconf: replace non-portable += syntax
From: "Sertonix" <sertonix@posteo.net>
References: <DA4CXNXDBZB8.9AQO25002X65@posteo.net>
In-Reply-To: <DA4CXNXDBZB8.9AQO25002X65@posteo.net>

I forgot to mention that this patch is for nfs-utils

