Return-Path: <linux-nfs+bounces-1021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFE582A275
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 21:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A828F1C22DB2
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 20:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157E4F603;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcJTj4Cd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86551C5E;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 949F1C433A6;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919125;
	bh=jqVJ65PjAdptZLt/APBS0SPrv8D3nmlTfilvmJfxIV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KcJTj4CdRpWb6G9Tb6QhW8NkOOPiIXwITosMIGkuseTUdc547qUsTOCb5JBPQjYFS
	 BFXWUrVK5jzeTrap2fTe0UXVhR0IVWcOcZMUNRH16+8rql5+Va8zpN/HCL5Q8LDZa/
	 fOfFWoluxTtYdRgxdwiNAKLxxbCV1d6s+bXlswjHtYkBhTL0+majClvIoBBQWbtx8X
	 bP90zTGW2TU8GnI9AawR7aOB0vS3L7Omnh55/gPPLFoaALxoV/9KpL2E2GZirA1Vk1
	 TjP+e9UbZSYAim7g/N3SmpUwUH+xOIiUWSzeFfnL3zFpxXkVDiHA5aZTp704hWAtjf
	 +vtPvzpRPJ5AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D2B2DFC686;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202401081012.7571CBB@keescook>
References: <202401081012.7571CBB@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202401081012.7571CBB@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.8-rc1
X-PR-Tracked-Commit-Id: a75b3809dce2ad006ebf7fa641f49881fa0d79d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 120a201bd2ad0bffebdd2cf62c389dbba79bbfae
Message-Id: <170491912549.22036.4098527230662245491.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:45 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Anders Larsen <al@alarsen.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anna Schumaker <anna@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Geliang Tang <geliang.tang@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gurucharan G <gurucharanx.g@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Justin Stitt <justinstitt@google.com>, kasan-dev@googlegroups.com,
	Kees Cook <keescook@chromium.org>,
	linux-hardening@vg.smtp.subspace.kernel.org,
	er.kernel.org@web.codeaurora.org, linux-nfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, Marco Elver <elver@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Neil Brown <neilb@suse.de>, netdev@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Monthero <debug.penguin32@gmail.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Tom Talpey <tom@talpey.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Xu Panda <xu.panda@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:20:13 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/120a201bd2ad0bffebdd2cf62c389dbba79bbfae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

