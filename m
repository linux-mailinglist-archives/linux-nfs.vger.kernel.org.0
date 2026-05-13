Return-Path: <linux-nfs+bounces-21584-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM3MM+7eA2qA/gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21584-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 04:16:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFB52C327
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 04:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E2130A233D
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 02:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39638386562;
	Wed, 13 May 2026 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6LDV1b5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6944360EE6
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638509; cv=none; b=TaoagG5zbxeY3gJfLw3DPtc8gng8t1XKaYOsFW6gVj7k7H3HY/4hizD6pZqyU9zNiFJOJXgh9pJeEqxeDMXNqyHYSw7POyR3J14MzRq4wh093RMMar+BU6Pq0fDEGJVZ+iifpzT/Y863M3quPIQV/SOgCQ9AXmuyKbk3vjUBjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638509; c=relaxed/simple;
	bh=tlu7E9a42EdO8Zb4bF9ZEOeSFpy0O6JOTEoFq9gBpMQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NPxx0YZRNK0P7hvgFO1057ZDBCNohOqVV0IZIlekrvN+T5LBsonzQMAEwkZ+tgHIvL0gNyBw6fqcdsO0rbQg037UcNb/b32OKNc6qRZdXcV6ti87vdhTvl85EV6cKKnQ+YRuf9z919uZkHlAyu5LWby8lV4VjxaRyQY9wZW/Yj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6LDV1b5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c82471904fcso2708695a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778638507; x=1779243307; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlu7E9a42EdO8Zb4bF9ZEOeSFpy0O6JOTEoFq9gBpMQ=;
        b=i6LDV1b5mDErIAzCZK+iwWh5MUCar4bpILro7zX9pTN0yUCPqzYDVH4TfwcTJSVap/
         +xUcCunJ4mH6723+FhnZC/rFGauFP9aORGliDejy780K/tloDiLAAauUxMstXxezQDHw
         RCZKZ/JlQxlcKG5qC1r0IiNux7j7ZNl9F0Jv5foLyXLYrzHO4a+lgNpOctfP4GIyNhmh
         IJmI2/0iZ2RSwXOd/w+ZlioLw5H5sZPXs3xm/c1/uODdO9OHWNAEdumj9/qLuXECbTB3
         drOiXf2RltrVljku4icerrE4d5FFMIIiU/3URQahhmA3xf9J7+djv3j8i2C6L1oq6hR0
         XghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778638507; x=1779243307;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlu7E9a42EdO8Zb4bF9ZEOeSFpy0O6JOTEoFq9gBpMQ=;
        b=hB0+YFSS//nrJ3RUlCpdoc6EUQaivIWvq+40Ip1D+0BJZVsBUX9aT2gsRKaGitBc92
         hdWkmfclrJPQVzdy8gKcPXVGoUpT0XHg3b0Cx9cNbizbxMLLfkqYjbfNLo/+yl13dusF
         R/wNv4f5Q9WzPL1SrUtHQ/5osUl+zPXkQSCHC7x+FiNF7J1lOSwwCRjzWzmiMLr/vjGo
         0rpZ0LI1Yltsip/vgPLwS0LH89PctapF7WeUW26V0Ia3y+QLPkpOLvoAfVQlm5E5d+XI
         Wwws6hcOb5AkcGHzwNYkbx0IMslGXS0wsVwvQKsDZ4F03uX7tyzLY06FZdC/8ir9FJIn
         UWUg==
X-Forwarded-Encrypted: i=1; AFNElJ9FmCJRDwCOWlis9LkejZ9QV6zxnY6PPD1gHnMizAJhHVxnHf2kCWJavVMEliB+FGplcxLETecVAjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCS40/5iGF3xdcg8urK8CwRYOWdcCFf4rb5d8TQ32U95L3tgY
	yta4lMe1e1QlyImTMAX+Kxhqln6hnwSO6Z4GvmG7o4aWUefNp85R6j2i
X-Gm-Gg: Acq92OHpZV5+9PX7gfvEykG2r+HzyRkNSD28AJ8E6gcAs3ABivDhj/9xK46TlaAuhKY
	U61mdR6yjvEvxsj9NSNI3JBToGZYWJ4xDpPrJZXDeEjU1V0AYiYqLfOVHyOwNAkcWBwyglo9RU2
	Dh9iVpF4+83EHeLo2+Ziq6z26uC2CUkfj1Js68/s7+qar66W3yntbSh5Ywg2eOaKT05yxO2tRfH
	6b2PhP3oqNLh2Xe3llYAfdaDgRK2Evk/ILadMBuHvneIJO8WxmV2aqJb28DpeL0OhLiHKVCeW7g
	Gvqjd9d2XO/doDRrhVIdOx+DtqI3OvFFuaacETuSHeCngFhpVjcDXLynePPTC6N4X1bhkhrRFo4
	9ZyaWbSHFPMlLLB1kcGLVoE9N70eCFavm6y4yvfQfxqvHGBUev+K59o3LJMe7wF0lbcfGs5k2v2
	YZVkGiPLW9DJzuVbYnbspzog==
X-Received: by 2002:a05:6a20:7346:b0:39e:f6bb:48f9 with SMTP id adf61e73a8af0-3af80a70ee5mr1215571637.15.1778638506562;
        Tue, 12 May 2026 19:15:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767bf53sm13040829a12.6.2026.05.12.19.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 19:15:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 2/3] mm: track DONTCACHE dirty pages per bdi_writeback
In-Reply-To: <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
Date: Wed, 13 May 2026 07:37:06 +0530
Message-ID: <zf24qcz9.ritesh.list@gmail.com>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org> <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 36AFB52C327
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21584-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Jeff Layton <jlayton@kernel.org> writes:

> Add a per-wb WB_DONTCACHE_DIRTY counter that tracks the number of dirty
> pages with the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE
> writes).
>
> Increment the counter alongside WB_RECLAIMABLE in folio_account_dirtied()
> when the folio has the dropbehind flag set, and decrement it in
> folio_clear_dirty_for_io() and folio_account_cleaned(). Also decrement it
> when a non-DONTCACHE lookup atomically clears the dropbehind flag on a
> dirty folio in __filemap_get_folio_mpol(), using folio_test_clear_dropbehind()
> to prevent concurrent lookups from double-decrementing the counter, and
> guarding the decrement with mapping_can_writeback() to match the increment
> path.
>
> Transfer the counter alongside WB_RECLAIMABLE in inode_do_switch_wbs() so
> that the stat is properly migrated when an inode switches cgroup writeback
> domains.
>
> The counter will be used by the writeback flusher to determine how many
> pages to write back when expediting writeback for IOCB_DONTCACHE writes,
> without flushing the entire BDI's dirty pages.
>

Using wb_stat infra was a clever thing to do for counting the number of
dontcache folios.
I see that we don't collect DONTCACHE stats in collect_wb_stats(), which
I guess, is mainly for debug purposes only. Either ways I am not sure
how useful that might be, since it only shows the approximate stats
since it doesn't do wb_stat_sum() for most of the other stats too.
If for any reason we need that in future, that could go in a separate patch.

For this patch - LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


