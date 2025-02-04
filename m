Return-Path: <linux-nfs+bounces-9869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C535FA2735F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 14:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01C33A3AF7
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1121323B;
	Tue,  4 Feb 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1Bfubm6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950720C494
	for <linux-nfs@vger.kernel.org>; Tue,  4 Feb 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675782; cv=none; b=CDxGsQ59FGBQokOxg/WuReF2PMD5EEoF+nhYWqNOvNmpPn82AKhieXe1DS+DdbIYmch9bpx+2xJbQDzWy6cM9uRNxrOcT13ipymR0/Cz8Dw9ki/t9ZJBN8mVutnapuSpk9Ki5K6L5AV2HerBKEuu4GfpAW/A+I6pcNRUrwRAs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675782; c=relaxed/simple;
	bh=4Vh9xvGNvhO5AC4RUZhlM0hk7s+e4WYBp/qe1x7TM9U=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=p7K1UiIcMJt5LYlgpEsJQ6CU9xL3FNuKDtAuH4sXiax73Cf2tDruWwsgenB7jRhDFl6o61kWh5p5v/WZ97+z3icLCpKtnEPWnClHK7Wv6w4n3t1TG+oNHOwEqFtpr3ncAcw/sqOIFzl7k6MjFuH0qUX3V6Xom/1iPurbct5CV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1Bfubm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA66FC4CEDF;
	Tue,  4 Feb 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738675781;
	bh=4Vh9xvGNvhO5AC4RUZhlM0hk7s+e4WYBp/qe1x7TM9U=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=C1Bfubm6AhAf0N4ycullos1oOrSIXH5g52NUQrhx67eT8kGG1CnI4G4HDvgy2Wta1
	 ZPiuZsYzehpYFAHCpVHM+eKm4HE+kiNIyFOXD2Qsk14YTS5gr50dTgJhGeIzRTdu1a
	 bqvcc9yqUn+JXpLE4xSNMQRUMxLfKYRhENc36Zj9PcbkdmIuqwI3VlFRrsxn9oUK4J
	 w8fI2O76e8O8XMrAqVqx/pFNprNhvUCMoxecTRB7Ebg8RbO0c6ZKBicHd5p/qIfan6
	 9q2wFwjnogXuWU/S9qvghHHFQFkBUeyjyI8VuvhTHocxJ9chDoSiM58iHlyT9255Ee
	 9PzOirs0q9W8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34196380AA67;
	Tue,  4 Feb 2025 13:30:10 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 04 Feb 2025 13:30:12 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, cel@kernel.org, aglo@umich.edu, 
 trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org
Message-ID: <20250204-b219737c8-56e36733bccb@bugzilla.kernel.org>
In-Reply-To: <20250204-b219737c7-947e192554be@bugzilla.kernel.org>
References: <20250204-b219737c7-947e192554be@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to rik.theys from comment #7)
> Is it possible this patch has not (yet) been sent to stable@vger.kernel.org
> so it ends up in 6.12.y?

Commit 1b3e26a5ccbf has been in a publicly released kernel for exactly two days (as of this writing). It will take some time before it appears in any LTS kernel. For now, if you would like to test the commit, you need to apply it manually.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c8
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


