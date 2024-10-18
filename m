Return-Path: <linux-nfs+bounces-7296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4339A4852
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 22:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688B8B25028
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B9020C003;
	Fri, 18 Oct 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAVh8YO2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCD20969F;
	Fri, 18 Oct 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284130; cv=none; b=ahi/nga59QpoOtJ9IWIal8yF7ErUAlHNdAivSGvVDkJSNeL76f+OjMHl9IcWaC5y7wCBtsBtzVO1+1lhJ+1EviwvHumKZBgo4jKr1e/Yp97eHyPkwE3PgSPjdO+xEBh14xe/0DXqP09OsrrhRu/qqi8glrTa5eOk/NHMOfab+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284130; c=relaxed/simple;
	bh=+mrvC6j56s7aFgKx+SwdjYZgi4x8eKKrAcOIfqL4Xyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlBd2rMjBmdur/b0BJFvIs9BQc+0L9cm+plJD9VrActORqjkhvO4qubAYxqs4pePdjE7y/x0oh65uWjPVydNe1IPZkpODjaruKhA3e/kbAKAiEy5H7U5FPGEaZVXII+Fq6M6dKhMnHqQ5L49eUm+S8/ptC2iuaZx0lQL4FvVxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAVh8YO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F933C4CEC5;
	Fri, 18 Oct 2024 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284130;
	bh=+mrvC6j56s7aFgKx+SwdjYZgi4x8eKKrAcOIfqL4Xyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAVh8YO2a2ocPlyFqWMN2WZHCLhSf1uwWefj7ZjNJqwAFRW+QdOPneQvDQWw3YO8Z
	 nWRNCkE/os9HGeU+1x6jE0g5gHlR/pU4bjTyoA8DjWzO41VFEnKJFJM3vPtWKGn31u
	 nAZhEMj1O0pNbq7LURJ2ebACY5W3ulZxQaFXffwUX7kfiUbzTzxBM93pJ9IQ3UrRoT
	 a5pYV0PBOTPFfqnqBOUGjfJbBy6JeFI96O/IzmERkggYTTVqLHF393Q3CR7Q+IGebQ
	 qURCxPsS5Q3uPStgZLJQzfGaCK6ao6qTaRP3ZVR0FKl2O8tb37+w7+93vMReVxnxdZ
	 4jhnSy9GjZ9pQ==
From: cel@kernel.org
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] nfsd: fix race between laundromat and free_stateid
Date: Fri, 18 Oct 2024 16:42:05 -0400
Message-ID: <172928406306.238262.5519419327873788555.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018192458.84833-1-okorniev@redhat.com>
References: <20241018192458.84833-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 18 Oct 2024 15:24:58 -0400, Olga Kornievskaia wrote:                                              
> There is a race between laundromat handling of revoked delegations
> and a client sending free_stateid operation. Laundromat thread
> finds that delegation has expired and needs to be revoked so it
> marks the delegation stid revoked and it puts it on a reaper list
> but then it unlock the state lock and the actual delegation revocation
> happens without the lock. Once the stid is marked revoked a racing
> free_stateid processing thread does the following (1) it calls
> list_del_init() which removes it from the reaper list and (2) frees
> the delegation stid structure. The laundromat thread ends up not
> calling the revoke_delegation() function for this particular delegation
> but that means it will no release the lock lease that exists on
> the file.
> 
> [...]                                                                        

Applied to nfsd-fixes for v6.12, thanks!                                                                

[1/1] nfsd: fix race between laundromat and free_stateid
      commit: 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a                                                                      

--                                                                              
Chuck Lever


