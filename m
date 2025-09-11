Return-Path: <linux-nfs+bounces-14293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE2B5354E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14851CC1AC0
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE3338F54;
	Thu, 11 Sep 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcLuDQOg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9943277A7
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600987; cv=none; b=exR5KCkRe59tfNgry1VyP9HwEhjspkFRovKy6YMnHxV+FZqtV7KCutR0TXRAK8ysU7dQxwLZ4fk/KXeurETYqX5dpEWo7gL2oFcWGBbE+7YaBlRzH/CcA+Mv6936PdsnWNzY0IqmtojmNbBgtr3OLJwkoWBA8eZQ0yE7kiB0Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600987; c=relaxed/simple;
	bh=R2Okl1RxLWSb9jkx6+JNlfm30A8y44lVrLedlMps47s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tn1sZ0Qsnhf7icHx4m2yvJJupKrxjuO62MTfZvdvQPgY4F9GLLiqnlCYuWgw0Zn9Ie0wTOEMJpfFuaBA6dgFO51m6hrihrVOPSx9anTseqpv9RxVUV5BAZxYArW0L+UOP06JAtTJn/3lJOLx+m0kuXq7sqoW8mDqN4YWxfrW3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcLuDQOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53B6C4CEF0;
	Thu, 11 Sep 2025 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757600987;
	bh=R2Okl1RxLWSb9jkx6+JNlfm30A8y44lVrLedlMps47s=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=JcLuDQOgbrYAS5tbV1gq0BX83GqO1ZVozEYkDnaQY0V2JvQVLkhzrH119TEBZmDDo
	 Y1SSiptA3OBGrJR+WQI9ZR+inhGSle7yKAMUigG/wJSrVZBacdtrWoJheKlPzewabd
	 jl7tPBrh6pttwoU2IyBD7xFIyYuYgmx3ZpF5E3cSgf9IEMYfAaVlfK+lqnRvtZogsC
	 lkHAxHoA+zfNoAxh5/PDDczon3lGF+4DGOfc4MUqFmxCSDdi7dNooDVDkVZQEICGRm
	 v8nGtfg6RRY2EMooObo2gjR0IYf/yLOiwxADHDZ8SjMG9UnL1Ekzv9FKsX5qo6k7NX
	 /NJYq1y95PAqg==
Message-ID: <3729660588543ff1d8c0b3c014948559b158cdad.camel@kernel.org>
Subject: Re: Where Is Dirty Data Flushed During NFSv4 Delegation Recall?
From: Trond Myklebust <trondmy@kernel.org>
To: Zhou Jifeng <zhoujifeng@kylinsec.com.cn>, linux-nfs
	 <linux-nfs@vger.kernel.org>
Date: Thu, 11 Sep 2025 10:29:45 -0400
In-Reply-To: <tencent_6A84D2E177043C91217A1CF6@qq.com>
References: <tencent_6A84D2E177043C91217A1CF6@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 10:30 +0800, Zhou Jifeng wrote:
> Hello everyone, I have a question that has been bothering me for a
> long
> =C2=A0time. I would like to ask a familiar friend to help explain it. In
> the NFSv4
> =C2=A0protocol, it is clearly defined that during the delegation RECALL=
=20
> processing, the client needs to write the modified cache to the
> server
> side. However, throughout the process, I have not found the code for
> flushing dirty data in the kernel NFS client. I have repeatedly
> reviewed
> the code logic of nfs4_callback_recall and nfs4_state_manager, but
> still
> cannot understand where the dirty data is flushed.
>=20
> My question is: When the client is handling the RECALL operation,
> where
> does the process of flushing the dirty data take place?
>=20

The question of when to flush dirty data isn't determined by the NFSv4
RECALL operation spec. It is decided by the client caching model and by
POSIX.
Please read the "nfs(5)" manpage and the section on close-to-open cache
consistency.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

