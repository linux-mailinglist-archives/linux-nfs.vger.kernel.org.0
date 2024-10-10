Return-Path: <linux-nfs+bounces-6997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682E997F82
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBE01F25017
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7E1EBFFC;
	Thu, 10 Oct 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS5HdR9y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC71C3F24
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545711; cv=none; b=KL+3Wm/rSZPd4XsFSzvNfmay8+rQepTYchMYon4g4iT9ELlyDqqf4pQLiopIWpadMcvzdC1uMf0QA0fddFRWGY1xyc1e4seUzdYGkOxy6IT47c2EE6ORVnC/CPWlersCSNL4LwZRuX7AuXw5zA83bzl7sZ4bS+WCcbpRjHh6O1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545711; c=relaxed/simple;
	bh=LZyO/epmg98GkLQS660A1vU6gar6HNW3hT2lrYi8HIs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=jL7CrkdxlStJLdPPVUPUqX3V4P8yVmupC4mJ7aQ6FuJNX/oJH3bMoo5mCMzTBpn41RE/Qpjc/ZuHeqzczbQYX/d+ROUMU3XKOUa/0TIkKhL3hszWEzq0Z8Mc41pNbwFWXKh+AiQusAlJVoNqCYVB1NoDBcPtT8mMrx6mDi/TbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS5HdR9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B96C4CED7;
	Thu, 10 Oct 2024 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728545710;
	bh=LZyO/epmg98GkLQS660A1vU6gar6HNW3hT2lrYi8HIs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=WS5HdR9yYMsy+I22ZxAETE4/uZ28yYY5vMYiqYnW5idAglvdigKoRjV8CnY7nHyTK
	 RcGDG+PreHvDXdLc9nZt1peq5CY7Dm6a2QfuZwskOd4Pr1PJZMd1YMrGWWfKENDEuX
	 gh0L39zYu+HRPYng6p/9X3rrC2sQ6XzfyhIPpXmNaQN0m3hE6pfsAelO5v0u/F7TkR
	 BIvVfFsF9MVoJZgfqEAFlTB342ZlrsvNTbEqAa8U+Svq4Ixe8KMNXycqLtanZPIl0r
	 Z12yBdQOyXasMR2BOUJiNPFx3VS8tie/MS4RuiqiD1ooKt1QEOWMIwqTK7k/A4HjCS
	 zZ+lfyRAIEd7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3405F3803263;
	Thu, 10 Oct 2024 07:35:16 +0000 (UTC)
From: Janpieter Sollie via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 10 Oct 2024 07:35:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
 cel@kernel.org, jlayton@kernel.org
Message-ID: <20241010-b219370c1-a0797c85838c@bugzilla.kernel.org>
In-Reply-To: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
References: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Subject: Re: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Janpieter Sollie writes via Kernel.org Bugzilla:

sorry, turns out I was wrong (had to do a make clean before):
removing the "trim unused exported symbols" option did NOT fix the issue, it simply masked it, turns out it was hidden somewhere else

View: https://bugzilla.kernel.org/show_bug.cgi?id=219370#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


