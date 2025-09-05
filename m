Return-Path: <linux-nfs+bounces-14074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D827DB45A75
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F89583B60
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982EB36CE1B;
	Fri,  5 Sep 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvDyeDpZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8E36CDE5;
	Fri,  5 Sep 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082452; cv=none; b=VUef1eQKuv4JKU/kwg1jhtsXQRzM0vusfKFZbYhk/642wSZD8HRQOsf6VAS4KHBy5yEaucptjD6zbTgZgg9zZpMVqsU7vUZte1flFx3/N1b68x9KujKoUO4rtSNCEMTD8KqP3fGUE7Rm4eRb/cGekAda6eVJEgENTN5J/YM2nxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082452; c=relaxed/simple;
	bh=oXt0M68MsYn7KCvHrkIrG8J8CrRu4xOlhmFDU6mb7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkLOJdFTiDkYlFIcT4fiwy+3Jc7DTykPtidMVaqfZl5miAl+hp975un4LmUcnonq9nBhzIdp9wQkiQ1d46p/Lx+SQ9SaGdyC2L+AFgrcsvDwluSYP3QpP3lS/F+c3gtlKgvQ+mT89nN7a0v6fCmhFTXJT4AaXbVXuL16ugIJqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvDyeDpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461ABC4CEF1;
	Fri,  5 Sep 2025 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757082452;
	bh=oXt0M68MsYn7KCvHrkIrG8J8CrRu4xOlhmFDU6mb7pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvDyeDpZEYWgmyB1PlfnXK0h8h2bpepfTcwrXkq+fU0jh4UggSPu5p1AR9qsjCW5U
	 f8LLH5rqGqNo5d0NiIme/nLvLZX8yzv4iPfVjIT6RXo21RtK1CVdRmeuwEkQZ57PuA
	 fkOqHsQucjcmhx3KQAjWb6vFqDd+Zrk0l4Mm5myBfPnLkRXGI6LqWM9z96Fo+YfnAv
	 ZVucA0o49zzBz7CV1pPaGARjP7nidr43F1KuJgsh84ACC3MDiOYs9tKbaGHoOkwUED
	 XQKI3N9TKOyjM4+9iSsMSP1hXHRyqwOTN/tW+91ZD8Cyp8g/xCAhzchY4BB7O70pOJ
	 f8x35tTcatVGw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] NFSD: Disallow layoutget during grace period
Date: Fri,  5 Sep 2025 10:27:28 -0400
Message-ID: <175708243820.6199.8033490028281613257.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825131122.98410-1-sergeybashirov@gmail.com>
References: <20250825131122.98410-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 25 Aug 2025 16:11:02 +0300, Sergey Bashirov wrote:
> When the server is recovering from a reboot and is in a grace period,
> any operation that may result in deletion or reallocation of block
> extents should not be allowed. See RFC 8881, section 18.43.3.
> 
> If multiple clients write data to the same file, rebooting the server
> during writing may result in file corruption. In the worst case, the
> exported XFS may also become corrupted. Observed this behavior while
> testing pNFS block volume setup.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: Disallow layoutget during grace period
      commit: c4df20612a34b4713e81e0b3612a84481f6ae82e

--
Chuck Lever


