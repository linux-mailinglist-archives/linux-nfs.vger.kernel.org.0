Return-Path: <linux-nfs+bounces-14127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22FAB491D5
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9484E171371
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1630E0F3;
	Mon,  8 Sep 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gem5MGTO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2930E0ED
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342177; cv=none; b=BNCNQ4nOV1ZpzaB7XyMwCeKbbhP37JGmx1CoPf5Wvn/BCweSRWtPYL5oYenBAgZ3mIww7XmAQzi50A6YzpUw7i0RWaki1MKmL/SSlOVSpj+8k/sfVwVVnvg634Nae59lN/0j49n3aBGEgZpZssoWs9oJCpbQ96KuyEaJo5VzUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342177; c=relaxed/simple;
	bh=OYHKRldWIWFJBTiFRVINN/KTCeAoCfvdS7ehksY9eMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuRzljuAuokrW36FdAxeF572QGxLMqxfhwZwvYZT9EsZIOQXaeQLh9Hc35/81SXynrL9Z3400qda8+OK+B94+jj8z6ToJgJ0eeS1XDksIJndZF3y5sgAHtdlKSbjE3Y1f5ed/rTwlw8iLKEEONsXspYGNB0w9JVSI0ewW6M/v8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gem5MGTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2B6C4CEF7;
	Mon,  8 Sep 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757342174;
	bh=OYHKRldWIWFJBTiFRVINN/KTCeAoCfvdS7ehksY9eMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gem5MGTOc/xvDWOLqQA8hJIC7rOKR+cu5xmINOWLuFa6p9lUSWpzRVcV1fAQ3I354
	 a4yJLP0REmV8QOvk7TRqcTX1SkjkmcFJE0iVPAFpjqsUlwafplmqMqcX7fYJRGFAmn
	 Kn8Tq3pk1cbbZOze1vCbEHSorvzdvolxdlo+eUhoa4+gxx46CURHWXH07ZiBBy3QTs
	 +jQ6znMnvD5DLFqXj0HvrTLwWLT1r4rXqRYV8oBOAT7qWsjfaaJMRi8V8k31SFyvhO
	 XXYwQNIZ873puFIiybMlJwlX1bW9F79gGv7kKOX7gZP2FY697xsIXUYVvailuGkCbd
	 EWdp9poHoIvUg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: discard nfserr_dropit
Date: Mon,  8 Sep 2025 10:36:06 -0400
Message-ID: <175734214898.12169.18249075972960835834.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <175729544562.2850467.751680410529802310@noble.neil.brown.name>
References: <175729544562.2850467.751680410529802310@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 08 Sep 2025 11:37:25 +1000, NeilBrown wrote:
> nfserr_dropit hasn't been used for over a decade, since rq_dropme and
> the RQ_DROPME were introduced.
> 
> Time to get rid of it completely.
> 
> 

Applied to nfsd-testing, thanks!

[1/1] nfsd: discard nfserr_dropit
      commit: 8516b28610286dc9219371383a1a6f07c4569ca8

--
Chuck Lever


