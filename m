Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0642925DF83
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgIDQNl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIDQNj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 12:13:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5A0C061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 09:13:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so9303723ejr.13
        for <linux-nfs@vger.kernel.org>; Fri, 04 Sep 2020 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZJBOp0s8Ej6xn/QCTIW1FaE/rY1pxAB8yxD9eVx014=;
        b=pOyg5ca6iWaNGCMAjZXWcWJdasBHoMbKcIifoRtx70nktzuPmI7FZHQj0LA0FqwlHF
         DhSE8m1Ctppf4q0vwuTZk/lX0ZEYEEj2sQeTTU319ildoHII9vj1zacycZCh8gikDxHR
         B1BIj3bgUAwQmXOKvVWvebIBiC3JpTg+wGzcIk8eHwiOe11shJd8T0UDaOgqyXVYSkl4
         H6vnmCKLiepuudOHvEQNntU+8zEz/qBUi0DHXmjLZTNNLXqVVxuqbzbPATJXChZN0QNF
         kR9YYX7+5CRXz8FRcE8bVtA2WkYTULItsYBG+coPmKiMWimmSeNiARH3jTJbRnImI0yH
         0C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZJBOp0s8Ej6xn/QCTIW1FaE/rY1pxAB8yxD9eVx014=;
        b=nbZL17v9EtSvCpeg4dK5NJQQNtrPbL+Ai/KUHdJkUXfUgfmXYlgoEdtRSZ/TIYTWNf
         yMIhTJO91JURILuAbK2nEnbvJmXYhi/zAZg/N9fXw5S12WvoBnHLvk9lKYjedu7TJfpT
         k8+qT4Z8+SB6pN8T7cbHPCfsYQYJpt0q8Fmxh72RgtxCyNI3qK6FAbTqecl73smT2+Gv
         5mYCYFArs0jqOQ7cbSzvqM1vsbeYgDNhKyfb/hszBoOWgk9VFmv3E1KZ45bG+rRSEzI0
         qqEMYvK2E0jRRNC9CgMs0DBcVpGfJHhKS4ac/WnC+pszHvgXlGUR1CDfvlTEVXLXLb9V
         eXEw==
X-Gm-Message-State: AOAM531fcCiHLHl/xkaAglGmmgesP2Vs2LaGss/mISlXJsJz0Dc28K9M
        MFLkOvNNPIBnPan+HDXzNpEKJY9pxX8d05Q4cJ0=
X-Google-Smtp-Source: ABdhPJyE6DaPeubnRcko9Y5mjOPwNkJEGetUeYSBNQQyFxLqO+7hmGscOiLXemLXG6eR2gXirRsN67rQN5fXH4wmq8k=
X-Received: by 2002:a17:906:cc4a:: with SMTP id mm10mr7941001ejb.451.1599236017141;
 Fri, 04 Sep 2020 09:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
 <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
 <20191011084910.joa3ptovudasyo7u@xzhoux.usersys.redhat.com>
 <cbe6a84f9cd61a8f60e70c05a07b3247030a262f.camel@hammerspace.com> <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
In-Reply-To: <6AAFBD30-1931-49A8-8120-B7171B0DA01C@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 4 Sep 2020 12:13:25 -0400
Message-ID: <CAN-5tyH8xZmJ3Qsrh-Va8Mo1jALgZeg4DC01QPLc9+=XTr_Ozg@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 3, 2020 at 1:55 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
>
> On 11 Oct 2019, at 10:14, Trond Myklebust wrote:
> > On Fri, 2019-10-11 at 16:49 +0800, Murphy Zhou wrote:
> >> On Thu, Oct 10, 2019 at 02:46:40PM +0000, Trond Myklebust wrote:
> >>> On Thu, 2019-10-10 at 15:40 +0800, Murphy Zhou wrote:
> ...
> >>>> @@ -3367,14 +3368,16 @@ static bool
> >>>> nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
> >>>>                    break;
> >>>>            }
> >>>>            seqid_open = state->open_stateid.seqid;
> >>>> -          if (read_seqretry(&state->seqlock, seq))
> >>>> -                  continue;
> >>>>
> >>>>            dst_seqid = be32_to_cpu(dst->seqid);
> >>>> -          if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) >= 0)
> >>>> +          if ((s32)(dst_seqid - be32_to_cpu(seqid_open)) > 0)
> >>>>                    dst->seqid = cpu_to_be32(dst_seqid + 1);
> >>>
> >>> This negates the whole intention of the patch you reference in the
> >>> 'Fixes:', which was to allow us to CLOSE files even if seqid bumps
> >>> have
> >>> been lost due to interrupted RPC calls e.g. when using 'soft' or
> >>> 'softerr' mounts.
> >>> With the above change, the check could just be tossed out
> >>> altogether,
> >>> because dst_seqid will never become larger than seqid_open.
> >>
> >> Hmm.. I got it wrong. Thanks for the explanation.
> >
> > So to be clear: I'm not saying that what you describe is not a problem.
> > I'm just saying that the fix you propose is really no better than
> > reverting the entire patch. I'd prefer not to do that, and would rather
> > see us look for ways to fix both problems, but if we can't find such as
> > fix then that would be the better solution.
>
> Hi Trond and Murphy Zhou,
>
> Sorry to resurrect this old thread, but I'm wondering if any progress was
> made on this front.
>
> I'm seeing this race manifest when process is never able to escape from the
> loop in nfs_set_open_stateid_locked() if CLOSE comes through first and
> clears out the state.  We can play bit-fiddling games to fix that, but I
> feel like we'll just end up breaking it again later with another fix.
>
> Either we should revert 0e0cb35b417f, or talk about how to fix it.  Seems
> like we should be able to put the CLOSE on the nfs4_state->waitq as well,
> and see if we can't just take that approach anytime our operations get out
> of sequence.  Do you see any problems with this approach?
>

I'm not sure reverting the patch is the solution? Because I'm running
into the infinite ERR_OLD_STATEID loop on CLOSE on SLE15SP2 machines
which don't have this patch at all.

> Ben
>
