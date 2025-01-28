Return-Path: <linux-nfs+bounces-9724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C623A20F6B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B63E188A6B1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5801A23A2;
	Tue, 28 Jan 2025 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT2bqHus"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095C18A6DF;
	Tue, 28 Jan 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084041; cv=none; b=nQxI71L50OThJmQUQYMFcWXDN39B77a5svnNaTvr/mjtEOdKbPPz5piGWY+LGKNxLiqjW25wt8VeJ7/s8d83aQ10ay5fHmqo7Sr3HHN2JuUP+5avBGzFYSI2mEcoywfkIthr5zKpwZ78h1W0I2hnehkIwBvrKvDG2jHjWfZr6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084041; c=relaxed/simple;
	bh=QhV86tw/jT0sKJMDtoTRG3IRwCviKGs0OqTZ/8FeI/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRaW/rrihnST0JdPJEnMyo2WvRATNXpbwL9ngxGSF7QDvKmeYGu1UYPkdtFA8zZg79Vc5BMDAedPUztbsZ8sMH8BYLpmKOdIsAMHvyj1Fk63FUzKmxzXtqlFT79eEZMu47CYZoj/aokVCe6PVGv8jxWp6OwT11V60JXkvxpwBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT2bqHus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1219C4CEE2;
	Tue, 28 Jan 2025 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738084039;
	bh=QhV86tw/jT0sKJMDtoTRG3IRwCviKGs0OqTZ/8FeI/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AT2bqHusOoARLptojU2usQToIi9c6eu7QqX26PoW2oclPjD4ljxkhoCluG+K8ELsO
	 CWuGJk4lMfNnI8A0xvZ8rhx6M073rIxZ5fhkzuQIdr5I2gCxwKkip65fzAY/3yHXTN
	 9TtagM8LwQ6+THiaZOvvZKD90E7LOIylSGaaZTGFT8cOp+oCDksbyoBuhm3Mu2aTq8
	 2eJRlmxZoW2lPKTXYByJUQ+tCflZ1CA8Z39ikh8JJDZ9yOhi9DaRUmpGrLslJQkuf7
	 5ewlu60l8YDng77sc/UCQ1z/sD0vaHr6jJ3IJgzZbqKFeeBg64g6qzvitFFPscIw0R
	 SpovdTmdrccGw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
Date: Tue, 28 Jan 2025 12:07:16 -0500
Message-ID: <173808393439.39052.5320146579477812509.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
References: <20250125-kdevops-v1-1-a76cf79127b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 25 Jan 2025 20:13:18 -0500, Jeff Layton wrote:
> nfsd_file_dispose_list_delayed can be called from the filecache
> laundrette, which is shut down after the nfsd threads are shut down and
> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
> are no threads to wake.
> 
> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
> svc_serv is not freed until after the filecache laundrette is cancelled.
> 
> [...]

Applied to nfsd-testing, thanks!

Test experience should demonstrate whether more strict memory
ordering semantics are needed.

[1/1] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
      commit: 363683ced1718d66ad54e1bdf52d41d544f783b2

--
Chuck Lever


