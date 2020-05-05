Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880EB1C5CA2
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2020 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgEEPyI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 May 2020 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgEEPyI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 May 2020 11:54:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BAC061A0F;
        Tue,  5 May 2020 08:54:07 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h26so2332799qtu.8;
        Tue, 05 May 2020 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3uxQIYXEUSRnI5mMzO80Z7OA/WXwhyvyfvFB5PsW3M=;
        b=bi5sRw5T4v8EMdNLYVF9CC8SVI8wAQojk6MdL1BCSvnn67T02STBZUpPDIBHvnZCcj
         qgdLfBWVP5oOr1xw/TpNTSbFnbeJKl8zAVzdq7k+Q62ofw/xvXyuqy0+rMSJa55ebfyD
         2hDA3zfCyMkFik+CS6+t8cdyLMKrIxruqMr2fhYuwGSOSJnzaBd/M12op0boJdKOTe/m
         gxbA+vF5hc2qyc+9fVc9rBUM11bzyv3fXO1wS5dbKC6fgIpHHKX4eTQDtoCDGVm02EU2
         Cq9rFx/fEcJ/nrU8AHAgvDCIT9EqKOuAkq1YJYcEJ7mpg0bdhnhUr1V7qP+4E6AZ6DdK
         JCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=v3uxQIYXEUSRnI5mMzO80Z7OA/WXwhyvyfvFB5PsW3M=;
        b=kVzOthcKpuhOcALPO/fI9LGf1q26NCorXZQO6Jqn2eu9sQuDMRKyett8q4jXGKvUsk
         ClQs4n0GnsYC7yARzZSfAJ5bwbrvJoGQwlrI2FQJ48aRPhNahNwtt19loGFhqPM4IaOy
         s2RyJw3n9GupsuGKju5c3EQwbqgQFt/nJI1ntUuLt3Zs564hs/O8h+pIgLHXP1wE+I0e
         tlEoSWGeP0XMVKw0pTIw049SjmZX0l6E2Cf+jk5M2f8EwpUpdw6vBdGyvZsEnPz69lMT
         R0/6CfpDphbQsOF8FXOatNdIfvSBG+0yAlbCgxTbsNl6mXrn9w27f6ppvK7dXmeJn0fz
         l2zA==
X-Gm-Message-State: AGi0PuYMhEXP12oQxAh3laINrlyxbnllRZXyZe4s6HQ/nnMd3tWqBgs0
        L0BMudB9H2R1RoFztHMCt6a+vNmJIEs=
X-Google-Smtp-Source: APiQypJarG8TrXh/1uXdoQr9xHKdB5xbqE4LDytOnqLJJdhq9JAGkL2XlcLm36r5eeDId3XwYVyowg==
X-Received: by 2002:ac8:19dd:: with SMTP id s29mr3417047qtk.164.1588694047013;
        Tue, 05 May 2020 08:54:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5ece])
        by smtp.gmail.com with ESMTPSA id b11sm2092051qti.50.2020.05.05.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:54:06 -0700 (PDT)
Date:   Tue, 5 May 2020 11:54:05 -0400
From:   Tejun Heo <tj@kernel.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200505155405.GD12217@mtj.thefacebook.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505021514.GA43625@pick.fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello, Bruce.

On Mon, May 04, 2020 at 10:15:14PM -0400, J. Bruce Fields wrote:
> We're currently using it to pass the struct svc_rqst that a new nfsd
> thread needs.  But once the new thread has gotten that, I guess it could
> set kthread->data to some global value that it uses to say "I'm a knfsd
> thread"?
> 
> I suppose that would work.
> 
> Though now I'm feeling greedy: it would be nice to have both some kind
> of global flag, *and* keep kthread->data pointing to svc_rqst (as that
> would give me a simpler and quicker way to figure out which client is
> conflicting).  Could I take a flag bit in kthread->flags, maybe?

Hmm... that'd be solvable if kthread->data can point to a struct which does
both things, right? Because it doesn't have free() callback, it's a bit
awkward but the threadfn itself can unlink and RCU-free it before returning.

Thanks.

-- 
tejun
