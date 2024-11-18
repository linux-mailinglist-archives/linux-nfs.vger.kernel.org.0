Return-Path: <linux-nfs+bounces-8037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 772DA9D13FE
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 16:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2381F1F2186D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D81BD9F4;
	Mon, 18 Nov 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSzBdrrh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A71AF0A5;
	Mon, 18 Nov 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942240; cv=none; b=nIVVzX12sBDyewPSqIGQaFYY/7Dresesr1nwQf6+z6FT12E4Q/0rDxPa9wS6YA8IfYvCArMvWIvKg9FDbojubxHiSK6+eQSqAUkMEyXSP9XZgJy0UpJbnVu2wJ4c4DuDLiA0WmXpLtPXztyYyXzHHnurIaeZO9M++Av8zdJZI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942240; c=relaxed/simple;
	bh=x7JTV8+qhEMe4IqVD8RW293cWMHp4TzzImSTS5jdvqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJ0DKKywdWs8b0nv3oXcQRux2iIvMsTvGTV6u4PFJ6Qmn2b/U+/e9BXua3jX7pRYLDK68OhpIjomxkd10bHlr8X7g1SKLbMNPIYXmbZvTLaCH2JwHeS5tW7u0CbECVSDwz/r9yWQBXf8PS7oRw27XblmJRfoPjuuEnybmArudSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSzBdrrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E2C4CECC;
	Mon, 18 Nov 2024 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731942239;
	bh=x7JTV8+qhEMe4IqVD8RW293cWMHp4TzzImSTS5jdvqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSzBdrrhKfGFZiKMtUHO/K6aIxDfe6yixouGNG56cV7si1nFVkloijfKY/AQ5Y/AW
	 j/bKUKFnKozZ/lAF6ItEKw6VYyR5EV9ZcH0GUqy3A5nQNAda/bCBrNR1OwshUodXS7
	 UeUoway6LcTtHC8aXgHY6qniGeFgQDubsq114zlHeHW6UK7olo1kJe1BZmb6L3ZQK9
	 8J5xdSSSi7yMftS9KR2jbnlbYWyKJtCeJwX1JzIoEBUktbu+pVMgxH8vx0xVs5hfE9
	 EM6w5iYU0pI1aFy2G/8CKrlfX6Agf2284YgEV5+o5D99hXhuVdmjwC20rQxNVgrc4J
	 kB4kmXr50C3xA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] nfsd: allow for up to 32 callback session slots
Date: Mon, 18 Nov 2024 10:03:50 -0500
Message-ID: <173194219548.79489.7363996743894936823.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-bcwide-v5-1-e21f211f2543@kernel.org>
References: <20241118-bcwide-v5-1-e21f211f2543@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=YCbZvaOuS25AufY48WzxiTmsYNusBd9t6jIscvoh0wM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnO1dWlQ0udTkKcI/dSwueg9/pFGoMycOwQNN0G sjWv+YFwU6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZztXVgAKCRAzarMzb2Z/ l1rGEACVS9yqk41BIrxD2gEZpfVWFBi9mO6o5/LtethWw49W9zRhKCgObVLOrY7ooApyWL7JPu3 MESWPJW3Po1yNzssudLO9/LJ4KnAQh9bfm/5EU7oNahtFhFoHtkbs/vwik876vyizBylXPG4USL /Dw9Uj8H3uL+ZP7i+U25BNifps5wZF8l6QEYztIN2m6ajRMnwzV08S/NUygFwjogqVEXXS8iuTr vRYmsHbj/av+MRR0FgaaobCcP+3roIV8RrHiVJ9vP8UwK9tSpte6rSzAuqAwAYVoVFQJW6fZ0SU 53KVddgHO1q07nS6Xd8NqK6eYdUiZ8FsfzHhieGbX3ctfL+du2h9aIan7AI5OX7UwVcSFyjBub+ VvyRl8EtBU+zKzJ8ZR350m76ohq3/xKQUbZgui8aNPdNDKqtWsZy17nsHgp7oUa3BlgNSL21YAF 959eFIsYaLxw5a6e7NwaOdxl8z+FxcpBla9+PYEsgM1fb+NDaYTtEM7JDf6xgfV8UB4USTaJJ1l aOjXV7MDAS6H9wXgdT3zOinEi3F6oNlO+PKXvkIFO+4NblTtwxB1F5EJYZ1Axm1cDKS4RN26BvB 08b+qdNGr3h4hgRb75YPbY09BhI8mjlZIeRp/V39l/5ZiRgwyQyGefTm6UuR4kZ4v9dcj5olhL/ aUe4bD
 CcV/PawDg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 18 Nov 2024 09:54:34 -0500, Jeff Layton wrote:                                              
> nfsd currently only uses a single slot in the callback channel, which is
> proving to be a bottleneck in some cases. Widen the callback channel to
> a max of 32 slots (subject to the client's target_maxreqs value).
> 
> Change the cb_holds_slot boolean to an integer that tracks the current
> slot number (with -1 meaning "unassigned").  Move the callback slot
> tracking info into the session. Add a new u32 that acts as a bitmap to
> track which slots are in use, and a u32 to track the latest callback
> target_slotid that the client reports. To protect the new fields, add
> a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to always
> search for the lowest slotid (using ffs()).
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/1] nfsd: allow for up to 32 callback session slots
      commit: a47e0534dc9cc3f9ee7c914cfddd6912855b5d61                                                                      

--                                                                              
Chuck Lever


