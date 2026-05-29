Return-Path: <linux-nfs+bounces-22080-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ4AFX29GWq0yggAu9opvQ
	(envelope-from <linux-nfs+bounces-22080-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:23:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E560E60582B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 436F33001335
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02513E008F;
	Fri, 29 May 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhTd7YKj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822B36606B
	for <linux-nfs@vger.kernel.org>; Fri, 29 May 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071771; cv=none; b=pF373ynY5yIPLsl6b0+0G0CmdwtBO35mX2T7LbToqs6KD+8+wPjL8Vh7R6rAZHT+0JVvaoRhLQWgkgO9WM7wM34hSwbK4jJzO50oE0kHRPWFATPCULDhgq2gZpX9i2S8dCh2CR6C4ntIbTamk/NJD0pXfbxlJscBU1M99RoydRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071771; c=relaxed/simple;
	bh=CyPwx27MMS9WC4YE17M2ZMeFit9r61EyDHKWlYRVXIs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=b9ZvYGV5qOsWZvzYCP8foga6yodT/Vy+Eir8/qKh1VrpjrdVjUAWCYqsokrVYqu0zVm5yVpC4S/c35hHxl927FYbsYGYH1e0Tr8/7IBAdxYybGUCvsocqTwiZnF/7VvcAyVYnKESH+cKkenTntF9X9S7F2UcXhfx/UmTnwMdugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhTd7YKj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1EA1F00898;
	Fri, 29 May 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780071770;
	bh=20ZOW4kw4v5oL04793XvsxjjeT/XlJ38mf1iMlXDFhU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dhTd7YKje4qrAWkvHwRxNsybYcfrkeFGuUImSPPYv20Ah2E75VOL1qPRlnBfIrJ0F
	 H3/cN1Uf3DWsIzyDQ+6rbneWgRXvYBs19D5stOUwB2hg0Ur0BaanbcNzTmjswvssZd
	 EXZ9LkLK6h6lvRBzye+J4ya91O5cPR8TuEMk8lfeQ9ddu/zVjjCv8eanwP83+bi3A4
	 yk60IbjRrXEU4fVl+0l+geqXwNgz8p4dqzmHhHZ8j6enaeUUiGjxf7qv6bl9pJvv0T
	 4F7w/O15Bihq8ROJUL5G+xCCDchFuuOuCZvqex/RG4RT+67MgIOUe/lrW2AqvyoDkq
	 7pwpvubzkjJvQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B3E3F4008C;
	Fri, 29 May 2026 12:22:49 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 12:22:49 -0400
X-ME-Sender: <xms:Wb0Zajo-LwcTcjxQcw5xtaKAQqH0hWDt8F9-ymTCoaOUX5zy5c3HdQ>
    <xme:Wb0ZaoduDAbEKwnGJ1PUZtoMjVH-uaKJxh1-B7M0PccrkJlxBFL9gZ3S_SK4GFhs0
    Treo5jkiJETKaoUgmDYtMNi3yMdscz3XXJaO1tat7G6ikWSfQOyDz8>
X-ME-Proxy-Cause: dmFkZTG1jwWpGVel9ocOA2dJNSB+0bg4E6qrSP5eRhBPZJr4y5q4+6qwLs+WGDfuOtfbAH
    spxvqF+iARhNSfGUJaBuY3eshp0hfZbEoTffDF3Va7V42+YmmA80eS37Jc6wKyjaIz6Lgg
    GGyQZhFAhmy6e4dKoVJbPQoRqBleBw+v9AvzPtfBiOslckhHJf4+/kFO3/9QXNokgYTNV/
    M2hHuV4H4gqnQgr8gPtaCxIDvqK1Aoq/Mt5muy5PYkg11XXx7R+o5UPYhqODjQIr4vE5ez
    kXGa/CLo6ir//bGhnZQviurSxhJbUldz+AxzmtiXOOwXAMOdxZInTySqBZWxVVGLhvpdkg
    UldlK+KOgczzRanoXL4YA4XmSSNWcwNySKoBuARm6sZ63kbyvLkn6N6BI7JTT1suXCn95w
    T+Gxw65as5JsfVnI9Dr+URnXt7LJOBVHDRMdqt/M+qUWIydGzohN8mz2eTxKBhoaSu5GIG
    bY6fLkY943Fhts6vknhcjrPxuMVRgxWKveqHp5tAdGcyBZLhPjtBBP/drve/QaWgrY4eMB
    AUVtBkEUJ59kXuOO1fPQPECbKRwN0GvtJPt6u2Sab23YHoIIK8hvoqHBbKGYEzkgOZ95/d
    kwXsniUTu4QN06Y2rza3CIaEX+kfLBUMJz5MdEor05q7IeEDuK2LUmn9mGpA
X-ME-Proxy: <xmx:Wb0ZavlH02yAdXVCyEuQjTjfSZTJ572vWXAUFFN6q6XMUXfR9tNoMA>
    <xmx:Wb0ZaiR_kotY72NxaR4Ig2nOwNus8gXckBz8__6IymbT753-j0Z4mA>
    <xmx:Wb0Zamt_9QwqTD81bvsV2mzVsCsUmoOMp3JflYHnkS9-saRAoYav4A>
    <xmx:Wb0Zar7VT4knphUJ7jOHMn3WiDHwtHJNEHnPMC-t0ugu4skaf7y0Xw>
    <xmx:Wb0ZahgmEmGy9Pt2lwpyUhWATF8KsbzGg0CCzdLG8JHCrLYDDF7pAF0u>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04EA27800CD; Fri, 29 May 2026 12:22:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsRyyZpLZ90k
Date: Fri, 29 May 2026 12:22:28 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <6ffd3f72-0642-40f3-a302-9090e794aaa1@app.fastmail.com>
In-Reply-To: <20260528-nfsd-fixes-v1-4-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-4-e78708eff77d@kernel.org>
Subject: Re: [PATCH 04/10] nfsd: dedup nfs4_client_to_reclaim inserts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22080-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email,app.fastmail.com:mid,cr_princhash.data:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E560E60582B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>
>
> nfs4_client_to_reclaim() unconditionally allocates a new
> nfs4_client_reclaim, prepends it to reclaim_str_hashtbl[], and bumps
> reclaim_str_hashtbl_size with no check for an existing entry for the
> same client name.  After a reboot with a populated recovery directory
> that inflates the counter by one for every client that reclaims:
>
>     boot:    load_recdir()
>                nfs4_client_to_reclaim(name)   /* entry #1, size++ */
>
>     grace:   RECLAIM_COMPLETE
>                __nfsd4_create_reclaim_record_grace()
>                  nfs4_client_to_reclaim(name) /* entry #2, size++ */
>
> inc_reclaim_complete() ends the grace period early only when
>
>     atomic_inc_return(&nn->nr_reclaim_complete) ==
>         nn->reclaim_str_hashtbl_size
>
> With reclaim_str_hashtbl_size at 2N and nr_reclaim_complete capped at
> N, the equality never holds and the fast end-of-grace path is dead.
> The grace period always runs out the full 90-second laundromat timer,
> and the shadow entry left in the hash table carries a dangling cr_clp
> for any reader that walks it.
>
> Fix nfs4_client_to_reclaim() to compute strhashval first, look the
> name up with nfsd4_find_reclaim_client(), and on a hit fold the new
> princhash into the existing record (if it lacks one) and return that
> record without allocating or touching reclaim_str_hashtbl_size.  On
> kmemdup() failure during the fold-in, return NULL so
> __cld_pipe_inprogress_downcall() surfaces -EFAULT to nfsdcld, matching
> the miss-path contract.
>
> Because the fold-in writes cr_princhash.data and cr_princhash.len on
> a record that is already linked into reclaim_str_hashtbl[], pair the
> two stores with smp_store_release() on .len after WRITE_ONCE() on
> .data, and have nfsd4_cld_check_v2() read .len with smp_load_acquire()
> before READ_ONCE() on .data, so a concurrent principal-hash check
> cannot observe a torn (data, len) pair.
>
> Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations 
> when using nfsdcld")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>

The motivating example in the commit message is built on the legacy
recovery-directory path, but the bug this patch fixes is nfsdcld-only,
which the Fixes: tag already reflects.

Could you recast the example around the path the patch actually
repairs -- a boot-time cld enumeration record followed by an in-grace
RECLAIM_COMPLETE downcall for the same cl_name -- where the records
are keyed consistently by cl_name and the dedup works?  The code
change itself looks correct.


-- 
Chuck Lever

