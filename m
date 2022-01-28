Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C696B49F0BB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 02:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbiA1Bxx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 20:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiA1Bxw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 20:53:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64BC061747
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 17:53:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u24so6610666eds.11
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BksNA5S+udLGQFWNRur5mtnPIKBdIcol8nSGG5bpXY=;
        b=esFdDFaph7U2Rhf8i8w3+GyDTK6bATgu1eQZApvy6tgZyeZBVZ7S4iK+i2giHzgGhO
         C7PUaMmiPxLx67rOjRLEeZldRdYhwyyvoGxWfvcH6f1RiTJgwR6t5mAdS8sD5BVB4EpV
         E20LFd2HnHzKT/ImQj64oOerKbFxOkV3btqw5VbEuGjk7MsOZIk4npq9GVROJzQcifbP
         eon219Ij8PPL4e1a3eus6YcSuUS0gs8FeO5Gfacwn857JqMcgwxwH8J2S0IXI+l2YREs
         J4xPMeiqMkTJo9tipGj1cVHTG4HuQ7xL5gmDYDXd0Qgz9DGF6mGrQnuiK6S/M9SXJNa/
         5Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BksNA5S+udLGQFWNRur5mtnPIKBdIcol8nSGG5bpXY=;
        b=G+pNdVTHl8ZUwZsqPQASfSrnNQhe4BS9G7TD8OJuSF/hD0330Og03I5pgNeg5Yf3f/
         chlcFnkb1nRIBtwlVkQJ/pn8dc8F1T7WkywRhEOWSbnRfGRiNJNv7+DzaJ92rQRWni2j
         FsvP8qUm0YPBVWHeWuxYAYNyANTidTGkADoKPyemj4VBHO3X7Q9mvUs/ANUvGvmMBtXB
         ugMLlhbsB61r+8sEN6rAxOhF/v9xDqXUUOW41PrUteWB2E4B/yq2ZPuu11yYsVioMvkq
         Ms/LAnNkf5g2mBxl8+5w00+bQmd0lsJI4ppuajJb8niyC89MPZMtCDs9pr/qx3x3Qe0w
         nLgA==
X-Gm-Message-State: AOAM530mvlmW94/sVcFoeXfsX77m7Bhje+t3tdYCs7HTkrobn47P3yiz
        A3Xssr+4rUa+iodlvQ3MlyBaV5cST4e9VUl9InTaSxWNzQ==
X-Google-Smtp-Source: ABdhPJzS/fNYvMDz6oqEtIhz9NPgu0S5jmTalBOZ2xNAdzuLu5p/7iYGcqIQC9Hrn+co7coW1V3/d/BiY9Cpa3vTwNA=
X-Received: by 2002:a05:6402:4390:: with SMTP id o16mr5915559edc.343.1643334831162;
 Thu, 27 Jan 2022 17:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
 <YfAz0EAim7Q9ifGI@aion.usersys.redhat.com> <CAHC9VhTwXUE9dYBHrkA3Xkr=AgXvcnfSzLLBJ4QqYd4R+kFbbA@mail.gmail.com>
 <YfBGx+M9jQZa80rZ@aion.usersys.redhat.com> <CAHC9VhRoWbnV-cs2HzmiTEd7_kP914stdVpN9Tm2-6uua2-ELA@mail.gmail.com>
 <YfGyFhA0ZQPagROG@aion.usersys.redhat.com>
In-Reply-To: <YfGyFhA0ZQPagROG@aion.usersys.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 20:53:40 -0500
Message-ID: <CAHC9VhTOT-XfOQvjowGpOcG_S-hSoKZtGMwhwVZy05VHMyv3zA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 26, 2022 at 3:42 PM Scott Mayhew <smayhew@redhat.com> wrote:
> On Tue, 25 Jan 2022, Paul Moore wrote:
> > On Tue, Jan 25, 2022 at 1:51 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > On Tue, 25 Jan 2022, Paul Moore wrote:
> > > > On Tue, Jan 25, 2022 at 12:31 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > > On Mon, 24 Jan 2022, Paul Moore wrote:
> > > > > > On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:

...

> Sorry for being unclear.  The parts where the sids are (potentially)
> being parsed are inside an "if (opts) { ... }" block... but later in the
> function those sids are used in various tests/assignments.  So if we
> wanted to eliminate the four local context_sid variables (using the
> variables in opts instead), then there would need to be additional
> checks to avoid dereferencing opts when it's NULL.

Okay, gotcha.  I think keeping the local variables is the right thing
to do.  My apologies for not noticing that earlier.

-- 
paul-moore.com
