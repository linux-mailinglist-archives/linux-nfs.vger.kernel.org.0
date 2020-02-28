Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D451173D25
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1Qii (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 11:38:38 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:45064 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Qih (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 11:38:37 -0500
Received: by mail-io1-f46.google.com with SMTP id w9so4018233iob.12
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s6TbfQYdkdS79qRvr7elFHRX0zdIQXQBFFsFsnMk3to=;
        b=qYYHrJDQnxM9Z+YDbTZ9NdW4yWXkbrPy52Oxf0Pw4I3kClEr/KVKajEAAp+607G985
         q6tD0xXN/MiXxauNqrRERq3+FzRBqe7Z+7vWM/3oLCvafgwnsFe8KUq6L6e8XMJ9Y7WA
         Bc5WlLIinht045eXrIJ3H5yDFUb4WtsoXkLGLv8zi/kpKDdUBJlMOFabBWsOX0OZ8MEN
         pNsHxzzOIGDi7+r6Df83roczSnlmKGgI4ZK6U9Rq8XyYrFN04FUQC+YjEgAJDO7k+tDc
         s3JIRhQcYot26CxWz0PLvvhztAP35/ed3ZMt2dGhZjlJdjtbFctfw9DGVy51tMCuFY8c
         saCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s6TbfQYdkdS79qRvr7elFHRX0zdIQXQBFFsFsnMk3to=;
        b=jcw/sTgbe3+z24fZwnJT7AOM94YR6L5fNN6XouMCmiKQ9h93tcOzZMK6tIx5NJfl5B
         jFsL43CnCRADOM7NKKcFjti6985gdD2fNxGGQgvUf3pAuL0TapgxjGlt4GxNeYitY7F7
         Gd3DiNpf6eiAVA/xlZnWXGojQVnRt5G+zBq5Kf+Vq2tJYxbMNJH8C4bmG0Mrq5Z1d+tm
         8xJCmyNe8ZgsM8TX3SthdWiP+mC8gsn5SlGWNGTkGbbfSTC/25Fdwwvk1PYrplY/P4l4
         DgJl2L762jVYmKql/853XVp4CIhlU7O27AXQ34aKI7h8UtsWS/9VqA1vdlaJWbK8vg88
         J9ZQ==
X-Gm-Message-State: APjAAAWtx9i6QaHlRQ3/SV2+hXdSkF1A6pEldGrtUA2rEiZgF1LjEbc/
        O2RH6HXLpSquTQgyUo8rEoOq4g==
X-Google-Smtp-Source: APXvYqwrMGBlylPS48mLsLMKDbUHZjva1zmfEeGk3t7XP+MX266DsHPKGFoOe8p9Af2uUZ1JMNw3dQ==
X-Received: by 2002:a6b:410d:: with SMTP id n13mr4322042ioa.101.1582907916542;
        Fri, 28 Feb 2020 08:38:36 -0800 (PST)
Received: from mail.matt.pallissard.net (169.121.68.34.bc.googleusercontent.com. [34.68.121.169])
        by smtp.gmail.com with ESMTPSA id v23sm1241338ioj.85.2020.02.28.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:38:35 -0800 (PST)
Date:   Fri, 28 Feb 2020 08:38:28 -0800
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: possible nfsv3 write corruption
Message-ID: <20200228163828.puahh5q5lplc6diw@matt-gen-desktop-p01.matt.pallissard.net>
References: <20200227162843.n2qjuka2rjc44qcv@matt-gen-desktop-p01.matt.pallissard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227162843.n2qjuka2rjc44qcv@matt-gen-desktop-p01.matt.pallissard.net>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'll just bump this once before letting it slip into the ether.

Matt Pallissard

On 2020-02-27T08:28:43, Pallissard, Matthew wrote:
> 
> Forgive me if this is the wrong list.
> 
> Ok, I have this super infrequent data corruption on write that seems to be limited to nfsv3 async mounts.  I have not tested nfsv4 yet.  I _think_ I've narrowed down to the 5.5.0 > X >= 5.1.4 (maybe earlier) kernels.  I had some users report they had random data corruption.  A bit of testing shows that it's reproducible and the corruption is nearly identical every time.
> 
> I'd like to get to the bottom of this so I can guarantee that a kernel upgrade will resolve the issue.
> 
> What winds up happening is every several hundred GiB[ish] we wind up with the first half of a 64 bit segment corrupted.  Here is some example output from a test.  My test writes a few Gib, alternating between 64 bits of `0`'s and 64 bits of `1`'s.  I then read it in and check the contents. Re-reading the file shows that it's corrupted on write, not read.
> 
> > 2020-02-14 11:04:34 crit   found mis-match on word segment 11911168 / 33554432!
> > 2020-02-14 11:04:34 crit   found mis-match on byte 7, 188 != 255
> > 2020-02-14 11:04:34 crit   found mis-match on byte 6, 0 != 255
> > 2020-02-14 11:04:34 crit   found mis-match on byte 5, 16 != 255
> > 2020-02-14 11:04:34 crit   found mis-match on byte 4, 128 != 255
> > 2020-02-14 11:04:34 crit   1011110000000000000100001000000011111111111111111111111111111111
> 
> > 2020-02-14 13:38:11 crit   found mis-match on word segment 1982464 / 33554432!
> > 2020-02-14 13:38:11 crit   found mis-match on byte 7, 188 != 255
> > 2020-02-14 13:38:11 crit   found mis-match on byte 6, 0 != 255
> > 2020-02-14 13:38:11 crit   found mis-match on byte 5, 16 != 255
> > 2020-02-14 13:38:11 crit   found mis-match on byte 4, 128 != 255
> > 2020-02-14 13:38:11 crit   1011110000000000000100001000000011111111111111111111111111111111
> 
> 
> Knowns;
> 
> 	* does not appear to happen on CentOS/EL 3.10 series kernel
> 
> 	* does not appear to happen on a 5.5 series kernel
> 		* I'm re-running all my tests now to confirm this.
> 
> 	* not hardware dependent
> 
> 	* not processor dependent
> 		* I tested 3 different Intel processors
> 
> 	* appears to only happen on NFS v3 async mounts
> 		* local disk and `-o sync` NFS v3 mounts have been tested
> 
> 	* It happens on random 64 bit segments
> 
> 	* It's *always* the same 4 bytes that are corrupted
> 
> 	* While often identical, the corrupted bytes are not always identical
> 		* the identical corruption pattern can appear on separate computers.
> 
> 	* It's *always* on words that are written with `1`'s <- this is the part I find most interesting
> 
> 	* whether or not I explicitly call `fflush` and `sync` has no effect on the results.
> 
> 	* usually takes ~80-2000Gib to reproduce, sometimes higher or lower but infrequent.
> 		* I've been writing 2GiB files
> 		* sometimes I never hit the corruption case.
> 
> 	* I've yet to see more than one corrupted segment in a file.
> 
> 
> A little bit about the build/run environments;
> 
> the hardware
> 	CentOS 7.
> 	CentOS glibc 2.17
> 	clang 9 / lld
> 	Dell PowerEdge R620
> 	Dell PowerEdge C6320
> 	Dell PowerEdge C6420
> 	Intel(R) Xeon(R) Gold 6230 CPU @ 2.10GHz
> 	Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
> 	Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz
> 
> * I did compile locally on every box.  I also tested every compiled binary on every box.  It didn't seem to affect the results.
> * I don't have a tcpdump of this yet.  I'm hoping to get that started before the end of the week.
> * I read and write to the same file every time, unlinking it before writing again
> * I have not tried dropping the cache between any of the steps.
> * I have engaged our storage vendor to see what they have to say.  They're pretty good at getting useful metrics and insight so if there is anything I should have them gather server-side please let me know.
> 
> 
> If anyone as any insight or additional testing I can perform I would *greatly* appreciate it.  I would be thrilled if this turned out to be some dumb configuration option or other operational thing performed incorrectly.
> 
> 
> Thank you for your time.
> 
> Matt Pallissard


