Return-Path: <linux-nfs+bounces-6491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA99795BD
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 10:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6B11C21514
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE91C3314;
	Sun, 15 Sep 2024 08:21:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D63CF65;
	Sun, 15 Sep 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726388500; cv=none; b=u7dwMO8bFgRa4QVeyFpjIhzEg6ZlR8bvymBqt4xyqPxe7tG8eh0OdcLVuFbRDxoiLgXfYyOqIWwcL1App8ckdroUhHZTB4VwMq4N4dTxU/Cxgwkme3e9knABQAb1hTejiPCQqQSF1c0e0MMVaEJoUoO9BuYI7S0zGgugO8+hGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726388500; c=relaxed/simple;
	bh=PeoedWCKagiT8z+bdtbNESZCqWIWuC6HOpNq4s4KZmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8gwJNJR6ngGxlpNFgIznIZEo1zUwAFnslMpX/WHJ+8SBPPvud4X72u+HuA5TkcXtjKwfQSAfOFPoU2vcGYzwT2cwJnT/wVFR5jhGwEZWSuZ+YKWTEGOlrard6aDaxUrJ/bcaQsycOGr+cd4uiFAbP+K5jDZS54gfwyTb+djfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D9DC4CEC3;
	Sun, 15 Sep 2024 08:21:28 +0000 (UTC)
Date: Sun, 15 Sep 2024 04:21:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Chandan
 Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
 <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 05/11] fs: tracepoints around multigrain timestamp
 events
Message-ID: <20240915042122.50635cc8@rorschach.local.home>
In-Reply-To: <20240914-mgtime-v8-5-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
	<20240914-mgtime-v8-5-5bd872330bed@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sep 2024 13:07:18 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> Add some tracepoints around various multigrain timestamp events.
>=20
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

=46rom a tracing POV, nothing looks out of ordinary.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

