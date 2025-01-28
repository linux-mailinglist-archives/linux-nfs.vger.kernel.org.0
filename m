Return-Path: <linux-nfs+bounces-9713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193EAA20485
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 07:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD63A77C1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1F1DDC2B;
	Tue, 28 Jan 2025 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="URjhJBtT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087B1DE2CD
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046243; cv=none; b=gShyrIGkfGkRA8gBesijv3LdIHsmRw1a2qctY/upVyVe8iYIaea8cEcCXhIHZAKKutpGhxmZ2dbHdnpObxC36TJqxPgx3tth6qVEwGVfYeDVL3LRjF/GgdJMiRYenY7SpSnv9Jm/jhO/oOBuiH/5YgFL/B6hgo6APRxodu7neys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046243; c=relaxed/simple;
	bh=8qS3bZcELSK16KPDP5Z328a53ghItbWS3xaSpljnhmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XepTSkZZbI3sAlEvtn6hiFNUt+7qRBUquJUl0IeQm1GHQHihkYBqZavHRMLIfxdcHMk8Sl1YjeoYR2OFwWy2QITGSG4KOGDlwx+4PvpAbNpmG8Hv2fj9FtOT69AXmLXLFFA+8mzfgd1E1NHEg20ZbI+xX62+JDnzA5faXScKnoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=URjhJBtT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21628b3fe7dso91993195ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 22:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738046240; x=1738651040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIlEsnjgTePJY675+XGFgicUtkr9en01LEoIhq6Oj6g=;
        b=URjhJBtTEtyadYSS7Juw2fSWsnIUS9VHBtHpE0UkFQfFElU2M488YA2uEzB4VxL9MB
         toobFrVHHaK9lmphq6q9nHsGzPTOiIGSrG5PA/k8CBOJ5qI/kmz8Clo2h+843jtzTd64
         AMX2O1ojh2Qu69OD99Wc92Qf6Tfi3SffXP49tnravmehEoUubggpqiiKQes5e4Pe4Sf8
         xgbZgFAyDiw5GyPucOFTXFQFTlNQWDAWT2EAOuPOKxQ2pADv0p4t3PVe/Oeshk5Qv8lx
         QUgiLG9rz/ANCHxL4IBwO6qruNnfD3idVKwj9qc4rXV3vulZqVYfI6fchIQfR3Vqk5QM
         g5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738046240; x=1738651040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIlEsnjgTePJY675+XGFgicUtkr9en01LEoIhq6Oj6g=;
        b=bWw1ZPzy3/WQVPbU5ppKMAZuSNmuU2cgCZcaeHM0Cerxe9UyrAGio15FUoOqYtE9eW
         XkMMtAxGI/EXpyaCoUdtRPD+y0c849cAR+Rrc6QiEqlCqv7my3Vy8yDfUWB5OGFa3UvS
         O3uQ8dEnv8jHdiQChGcPONHQET4u6KWUeecauxLI0ml4AGOgqHlVvcFl3HBHYLcm/UZT
         wdslfwr0JkQZ64uh2OdhL6qRIUj96rerYLwzmDCsJcI/qtXT1iBWq22AT0UsiooTiiSc
         ZP5/ixAx4QUEjrDQYmdrA/3Np1iPVqBvkLE38/X3SlYvkqK1Fqd+JfcC7EG/H4MOP/uF
         EBvg==
X-Forwarded-Encrypted: i=1; AJvYcCXJt3xqwGTgR3Anmt23nE68PU3sG1Mm3xG3jkJYDNlRjz3a5Jo4i7MRKAVOViE8fBPylQCUC6hh4k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKRbGc4QxbJdu2R+LHIwYtK4+ROpjh7dayvVC3PV3IGnvM6Mtc
	mBwjQe1PJTMAB76VY91NmsJYtzsUN740cbpyxSwqgKR1tES45CkYpFCLOMApd8Q=
X-Gm-Gg: ASbGncvkrThN4qb9TKHh0FPN8s1D0zkMFt0VIla/t78w7vur2tQYp7yME5DJSiLGC8o
	EaSUk/bwfF8kTuVJWgVSgcpzX5DqJjRybgIA60Z3HpG5qAEU2W+aez0C5Q5DyLpHvw/7jelUb1D
	0lY2UJBBU1eH//DQ2jLgVUwn2paQRVehc2dfIg4qWf3weWj55uXcQ1yFGva59znj24Ito97Gb98
	aW8Y3V2Twz7AibfPXh0roXhUvk09rFs6GXFmJO5Oyc+gne1BUwUfB4fMHUGYjDQt5dSOm2OiWkq
	4qRdFs2MR1X4X8KpjK9rdNDPM2dT4QyEUXjOHbIftVckJ7Zl84XXLNb+eEMhG1IQNL0=
X-Google-Smtp-Source: AGHT+IH1295iCPrfr4SxS7qVjK68HnkOJ5ZyskjlgQKLNAMhKeZObSb3zVYJAvIdW9F27pDqMSU1hA==
X-Received: by 2002:a17:902:ea0b:b0:216:48f4:4f1a with SMTP id d9443c01a7336-21c35503123mr672433115ad.16.1738046240366;
        Mon, 27 Jan 2025 22:37:20 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3adesm73723565ad.74.2025.01.27.22.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 22:37:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tcfDo-0000000BTsf-3AqN;
	Tue, 28 Jan 2025 17:37:16 +1100
Date: Tue, 28 Jan 2025 17:37:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
Message-ID: <Z5h7HOogTsM4ysZx@dread.disaster.area>
References: <20250127012257.1803314-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127012257.1803314-1-neilb@suse.de>

On Mon, Jan 27, 2025 at 12:20:31PM +1100, NeilBrown wrote:
> [
> davec added to cc incase I've said something incorrect about list_lru
> 
> Changes in this version:
>   - no _bh locking
>   - add name for a magic constant
>   - remove unnecessary race-handling code
>   - give a more meaningfule name for a lock for /proc/lock_stat
>   - minor cleanups suggested by Jeff
> 
> ]
> 
> The nfsd filecache currently uses  list_lru for tracking files recently
> used in NFSv3 requests which need to be "garbage collected" when they
> have becoming idle - unused for 2-4 seconds.
> 
> I do not believe list_lru is a good tool for this.  It does not allow
> the timeout which filecache requires so we have to add a timeout
> mechanism which holds the list_lru lock while the whole list is scanned
> looking for entries that haven't been recently accessed.  When the list
> is largish (even a few hundred) this can block new requests noticably
> which need the lock to remove a file to access it.

Looks entirely like a trivial implementation bug in how the list_lru
is walked in nfsd_file_gc().

static void
nfsd_file_gc(void)
{
        LIST_HEAD(dispose);
        unsigned long ret;

        ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
                            &dispose, list_lru_count(&nfsd_file_lru));
			              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

        trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
        nfsd_file_dispose_list_delayed(&dispose);
}

i.e. the list_lru_walk() has been told to walk the entire list in a
single lock hold if nothing blocks it.

We've known this for a long, long time, and it's something we've
handled for a long time with shrinkers, too. here's the typical way
of doing a full list aging and GC pass in one go without excessively
long lock holds:

{
	long nr_to_scan = list_lru_count(&nfsd_file_lru);
	LIST_HEAD(dispose);

	while (nr_to_scan > 0) {
		long batch = min(nr_to_scan, 64);

		list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
				&dispose, batch);

		if (list_empty(&dispose))
			break;
		dispose_list(&dispose);
		nr_to_scan -= batch;
	}
}

And we don't need two lists to separate recently referenced vs
gc candidates because we have a referenced bit in the nf->nf_flags.
i.e.  nfsd_file_lru_cb() does:

nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
                 void *arg)
{
....
        /* If it was recently added to the list, skip it */
        if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
                trace_nfsd_file_gc_referenced(nf);
                return LRU_ROTATE;
        }
.....

Which moves recently referenced entries to the far end of the list,
resulting in all the reclaimable objects congrating at the end of
the list that is walked first by list_lru_walk().

IOWs, a batched walk like above resumes the walk exactly where it
left off, because it is always either reclaiming or rotating the
object at the head of the list.

> This patch removes the list_lru and instead uses 2 simple linked lists.
> When a file is accessed it is removed from whichever list it is on,
> then added to the tail of the first list.  Every 2 seconds the second
> list is moved to the "freeme" list and the first list is moved to the
> second list.  This avoids any need to walk a list to find old entries.

Yup, that's exactly what the current code does via the laundrette
work that schedules nfsd_file_gc() to run every two seconds does.

> These lists are per-netns rather than global as the freeme list is
> per-netns as the actual freeing is done in nfsd threads which are
> per-netns.

The list_lru is actually multiple lists - it is a per-numa node list
and so moving to global scope linked lists per netns is going to
reduce scalability and increase lock contention on large machines.

I also don't see any perf numbers, scalability analysis, latency
measurement, CPU profiles, etc showing the problems with using list_lru
for the GC function, nor any improvement this new code brings.

i.e. It's kinda hard to make any real comment on "I do not believe
list_lru is a good tool for this" when there is no actual
measurements provided to back the statement one way or the other...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

