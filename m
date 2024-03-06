Return-Path: <linux-nfs+bounces-2217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7D873238
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Mar 2024 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED801C2215A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Mar 2024 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92714F7F;
	Wed,  6 Mar 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=legacybusinessforge.com header.i=@legacybusinessforge.com header.b="RjHEHRxA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.legacybusinessforge.com (mail.legacybusinessforge.com [89.46.196.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D15D750
	for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.46.196.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716201; cv=none; b=ipv3wpEynJv+AEZwMJ7GRbcxNd1CaVF2LLU8mjVXWgh+xa1ct5tV0RNWtaykm1R+1JRAt+Cl/05IjtV/8yACxRETEoZdTVoaBY0fg1SSrH6jHW3f7M61AXD+SFBJgASr88Vs4+u1YqxxuxBaFVTj89iUOS6scYdrxJxNy0R3pxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716201; c=relaxed/simple;
	bh=/cUArNAmQc6WFftlpOPyhmdPj91Fxkl3tORvLW/Y79g=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=P3eOqoeJoHCDPK43fIky8mvgquGzxq/2UAYh9wv+Nx/Ah20yTqGpKhWCbn89n13rNr+R2RZ95awwEZeJ60cOUA+6dg5svjq8eeaYlqpYtc0q1qV8xxaM6p6dYwQuLq8bIkKBaR+0lL8nRi3JdlzZ6kyv/03M8ttehYXbw4b05C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=legacybusinessforge.com; spf=pass smtp.mailfrom=legacybusinessforge.com; dkim=pass (2048-bit key) header.d=legacybusinessforge.com header.i=@legacybusinessforge.com header.b=RjHEHRxA; arc=none smtp.client-ip=89.46.196.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=legacybusinessforge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=legacybusinessforge.com
Received: by mail.legacybusinessforge.com (Postfix, from userid 1002)
	id 33E5482562; Wed,  6 Mar 2024 10:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=legacybusinessforge.com; s=mail; t=1709715663;
	bh=/cUArNAmQc6WFftlpOPyhmdPj91Fxkl3tORvLW/Y79g=;
	h=Date:From:To:Subject:From;
	b=RjHEHRxAmK2d2qMGI91A7FD8yRNtAdw+l1DV6/Xxdxo4JjamKR0h5uxwf+p5Ys40V
	 BsHmnQwdUn5RhTrxnzhIgs6wxiNtYGrdNLYqQT5rz45FSHsExccgpZc6xGaQNsi6oY
	 2EYhKllzyhWZcDare9ybRl0kDf6axHwE+ecHP/T/4ctYsCIdj7rEOB88Qu/5/eDRPY
	 g+PYIDdZDt53a2e8FQT/bNnrGyGmR/093a267GMqd6H4vU3CGwl19tL0I1Qz1fTXpf
	 AyfJKkAbfq1jNLqQp0bD+vWSoAbkr0QeCznPprrFq9ikl5E/GGe304zEhos67+MtmT
	 L+VMv9L9O9Z3w==
Received: by mail.legacybusinessforge.com for <linux-nfs@vger.kernel.org>; Wed,  6 Mar 2024 09:01:02 GMT
Message-ID: <20240306084500-0.1.3r.4qwn.0.moimmfmziy@legacybusinessforge.com>
Date: Wed,  6 Mar 2024 09:01:02 GMT
From: "Chad Felt" <chad.felt@legacybusinessforge.com>
To: <linux-nfs@vger.kernel.org>
Subject: Discover innovative educational tools.
X-Mailer: mail.legacybusinessforge.com
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We support curriculum creators, scientific equipment providers, and textb=
ook publishers in delivering innovative and effective educational tools.

With over 92 years of experience in creating educational products for stu=
dents and teachers, our presence in international markets allows us to sh=
are our expertise from the perspective of various needs and challenges.

Our solutions enrich the teaching process of STEM subjects, increase stud=
ent engagement, and improve learning outcomes.

We offer a wide range of products, starting from laboratory equipment (bi=
ology, chemistry, physics) for all educational levels, to biological spec=
imens (live and preserved organisms), anatomical models, laboratory chemi=
cals, scientific equipment, and ready-made sets for working with students=
 in lessons.

Our curriculum programs tailored for elementary schools, middle schools, =
and higher education institutions provide support on multiple fronts, all=
owing for utilization in various educational environments, including remo=
te learning.

Could I present how our products can contribute to the development of you=
r company?


Best regards
Chad Felt

