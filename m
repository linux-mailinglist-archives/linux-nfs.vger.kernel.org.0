Return-Path: <linux-nfs+bounces-7120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076399BCB3
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 01:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EC11C20B93
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BDC14AD38;
	Sun, 13 Oct 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0XNVRBF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC713D291;
	Sun, 13 Oct 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728861428; cv=none; b=mtOArOR9RfIiEblxy2FmJlSaV/EBnQ2IE44bhjdd3LEz/sB+Agj6PHv5uiPfF3NB3N0iwSEf9/BUybQXY1kAUYtcTEF5bbf9aHR4wjhZ0/u/IPDy7UEWAnVANCFjrJ5PvFlnI3tx99Al7UWo1IRN0/3WhlMNWrL0sgNQ+buDVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728861428; c=relaxed/simple;
	bh=T6fCpxQByFMxCFovCaie3y6UnkKaE2UUQlMk06KTWYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMKEzb2PKOguTpTgof/BK9vi0BE0JpKmrQTAYKfx1OfEks+rzDuKUk9Eq0uNCFprP1xR3WfO2P9okR7NJF3ivAdQTroakx7wSQxkqQ3WopgiSnKPcZly7HVEhqNWmn3MmS7RA0QJVlkqF6pzY3AZTKGY2D33af/NJG6nXpil3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0XNVRBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C057C4CEC5;
	Sun, 13 Oct 2024 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728861427;
	bh=T6fCpxQByFMxCFovCaie3y6UnkKaE2UUQlMk06KTWYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0XNVRBFUzrd5VvWsK2rIxro/ZetKbPWL43Y5ze+kyoS4mHeibbbTEjPcgqhMyBzf
	 1zy5oWZAdQjRuBSRNPf39QPbJ0Qca4HMYi2tQqmj83AbnKpOAxYfvmFipicEiAhb/V
	 J9TgBfQSPMg6toy7l3AfEYfQFKjQQ1GhzuQMeX9875ILJfcSxoeU5EombIQ9+fCOqw
	 LsSDlsqgmTxrHtZYTmymNrTMuYZqr3G9r/ybi/IU9+sOD5RkcIFxZZEZ+3hKAkM1jX
	 Fg8wpHXSZzd4GuE+bGMQWoWuS1NtDwbePH/MKXdXWkiDW9igjEG4P9E9EdpWRb9fPN
	 LEdz3fOYP/UUw==
From: cel@kernel.org
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] nfsd: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 19:16:55 -0400
Message-ID: <172886139200.172644.2516274640298579379.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241013201704.49576-13-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-13-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=/8YJRV9GFMeDkrzw3g6+IoigkBWNyS0S4UeL7zCFMTA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnDFTpEVs+lhLtZ9DMdFOdQYmEVyL0j1AnwYCn8 oz7Ed3epMCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwxU6QAKCRAzarMzb2Z/ l6T9D/98US6txOa/yiNCF9hDbrzwgk7MHT21FDI6/B4kt+/Uj21+mRN1U1D+iEfSlgIgg81OGKK sdH1NMATBHY5hX3La8Atd2jSB5Whm1u2HDgsN+zVY30V5tVaNkIAbvYKkhKHoAgZ3yDo+Ym/Sqd ET3xX8H3MxX846KLzdL+P1a+Om2qwMVTx6OqhcSD2vAFUZhSyYCHaIexqPraPvyo6CE65hrdyJo 6nedWwQLVsLhN2/p207FtQNStzvbm3gxnaZOXXrsboaRlckB1q5iBaQi3jj1VbQCNJcG0Ys0VP/ 8+92TThM72bBYuwdLgTxS4o+fCmG3LiCS5U+lo99DdEpfcnlSXWTGBwL00vduqiPSrx3cAFFqLy PtZOOuTfe7nDN4pDHPgWWYnfuIGQZ+tZFgBFhOEplhWdKtvPi4PNmX29SNshPDzdaCNXOSMhn/t y2VsBXAn1jvbamJzFju3tB8ihgSo7fTK/VfripbUwbGwlFXZTj4E7bBhUEaWW1ad8S0wbSZgSaW icpP8fzfUUi5ZLxoFggdpcbCF7QH8POkKgcWsgciEl1zm+hy+BSl1DaG/5Ocg0XRjZ/YckXgZYz gSKn4Lan+2FdSXbI/9G+OKOVAbOE9YrQSl+DOSWgxju0BPhZAisfjET35Y+NraQB6NONlsJriw8 0fU8K0L
 V4ov383Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 13 Oct 2024 22:16:59 +0200, Julia Lawall wrote:                                              
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[12/17] nfsd: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
        commit: 4159ced48564c9e6565e88a4774ff7456123f9d8                                                                      

--                                                                              
Chuck Lever


