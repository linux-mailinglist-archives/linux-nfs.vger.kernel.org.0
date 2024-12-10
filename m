Return-Path: <linux-nfs+bounces-8492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CD19EA7A5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 06:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E27188916B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 05:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B151A01C6;
	Tue, 10 Dec 2024 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFl1DC6f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B99168BE
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807992; cv=none; b=LtaKmXCJt0y1Mdaqs79oNJzaKHq/nGKaVWx2DIOOEaQ7U9+MLjLvGlYeS8wjNbivr/CkRysz8tDfyAGR75fAD3xvluTZYSkp6PG8wWQ7q0VxdovcDMjnM6km8UHuTKh5rUct9tcHgYsgSblCrdyCg4nf69eTpAeWBw8hS60pwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807992; c=relaxed/simple;
	bh=9GLyRFPUff5awRNTjVxHzw7NsnlDqnYFkiNDdgxdSEc=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=d+JI7pcNSO31Clw+ltzso/wT6j+BGks60ALTdCwakfHkaCb8PydDQ1L4A+QIFzfqlHMZPiwA3pdqndV3HkqcLOGLV7+UcP2CZ7++t4HWIRtZ8oeH6T3rvyBahLOcqJdk7m4iS7vu6V+TppaWfVF1smNetawAr0XTXYFTiZo4R/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFl1DC6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8634DC4CED6;
	Tue, 10 Dec 2024 05:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733807991;
	bh=9GLyRFPUff5awRNTjVxHzw7NsnlDqnYFkiNDdgxdSEc=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=VFl1DC6fbZSdOPwU8G2uYkUYKN1yXWHgxADLpscM2EleNP0JUrOMX5AYNmZK6j6ag
	 OYfaatzF8O8PE+CEB+OlKyzVr/rISeOcq6qA9H7MYDffFILKh3uHjNMUoOQ7+k9eYU
	 AHqCvW+HSoLjmX4sXx86/cMKZhEpXogFsXx7p+BIYjPituWXXVnkC69WkLihZz990U
	 cmHnz06TTo2kPr6JCxJBdgLPzVBijoZGjXFs0pv3H3CEGCSO/FYDiYRZRlMzYur+Jx
	 P90b1a995femOh7cCi2ODohkb25NWSAjw1UGs5WAKuH+egeq0dGYbOEbJ4PQeaY0gs
	 TuFI3nB+5mGwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39785380A95E;
	Tue, 10 Dec 2024 05:20:08 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 10 Dec 2024 05:20:14 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, cel@kernel.org, anna@kernel.org, 
 trondmy@kernel.org, jlayton@kernel.org
Message-ID: <20241210-b219535c10-2e3686615318@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen writes via Kernel.org Bugzilla:

Hi Mr. Lever,

I *clearly* stated I was using 6.1.119 which is the latest longterm kernel released on 2024-11-22, compiled by the ELRepo Project as-is from upstream tarball.

[136965.766148] CPU: 2 PID: 1856 Comm: nfsd Kdump: loaded Tainted: G            E      6.1.119-1.el9.elrepo.x86_64 #1


I encountered the problem in both shipped RHEL kernel and latest and sub-latest lts. So the bug must still exists in upstream. That's why I filed this bug.

Anyway, I encountered another 2 crashes in the last two days and call stack insists nfsd caused it.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c10
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


