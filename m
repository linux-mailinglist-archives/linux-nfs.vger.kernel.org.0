Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAABA147
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Sep 2019 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfIVGwm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Sep 2019 02:52:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36183 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfIVGwm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Sep 2019 02:52:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so10605591wrd.3
        for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2019 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=pEHE2Ci+UlkC3ZiSgMHdB5IekE6WuaqpwtszFtRGU3U=;
        b=t9iUuBnKhmthpGaxGrk3wRZnge1B+gzMCEfPlgbdIefYc+Jjgqo18X81hX9ttTVB0R
         twH42vjkQwO4SL830IQNEqmlXJg5BooGP5fCxKXjxTV2BxIZ0dmhJaoo2E8vAOdMu9+y
         EAUjU3YVPSFM/kmG+nPsre41bKVj41VgTGinNpEAMQlt6KXGTttJ8ZOQfIthDNSGNWyT
         neMxnskQwO405PmQ+uhvaQsg1GhvTyVAwBA8dNDOC7nk7FylyNScACI2N8j/eFkwdNyQ
         PhEb67/NFOUfePkuAgFrqfdQ1l4cruB/XX1EAxyUCrYMh/XzN3Qsvi1Xs1Tg1rKP8GV+
         +6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=pEHE2Ci+UlkC3ZiSgMHdB5IekE6WuaqpwtszFtRGU3U=;
        b=DF1N8eEvqouF+KJ4lKovRZmFhPiDoaXFsbrOZU54KLnBn4SozmIBWZx7mp5pgomRuC
         mS7/WvZ6xwCLSr55hCMw/rKa19bOOg8m1UrpNKevL+KTIv96R1pizfeP4+/jnowmrsJA
         ghucPyiU2LfNjWTJ0mQZIPnH9T+96MlHd+75Iw6imwO2Gu0dGtQEDoMgya2zD3LuuTDl
         ddhufCSR1YtGgnF59S4h5SB9qR1+57FtT5fFBHrLNpvt+zqGDheEPHxOyw1S2jI4xus5
         IgOqnsJQB+PcdGYZQbPNPGxRaZc+g8o8dRfY+gdJm7Cr6pmQ6kqb5ddt8B04ILfX2OtW
         ZMuw==
X-Gm-Message-State: APjAAAXnkxzM1POWq2Y42nvslrfGrk5Ua02H5/8Dw4jLpA4d/QnZkDnc
        2XS/pfAY7OPcaI1SDjN39rQyZw==
X-Google-Smtp-Source: APXvYqxOy/mrOQrkclFzQWjuEf8Bc4vlpBL2hINT/tWqNgisbJkvmThICmNm5FTcjnwfNKYGjxQKrQ==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr17700561wrn.308.1569135160144;
        Sat, 21 Sep 2019 23:52:40 -0700 (PDT)
Received: from alyakaslap ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id q19sm9517583wra.89.2019.09.21.23.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 23:52:39 -0700 (PDT)
Message-ID: <8F0FAB980E6F4594A8C61D927FE022E5@alyakaslap>
From:   "Alex Lyakas" <alex@zadara.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     <linux-nfs@vger.kernel.org>, "Shyam Kaushik" <shyam@zadara.com>
References: <1567518908-1720-1-git-send-email-alex@zadara.com> <20190906161236.GF17204@fieldses.org> <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com> <20190910202533.GC26695@fieldses.org>
In-Reply-To: <20190910202533.GC26695@fieldses.org>
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of a particular local filesystem
Date:   Sun, 22 Sep 2019 09:52:36 +0300
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

I do see in the code that a delegation stateid also holds an open file on 
the file system. In my experiments, however, the nfs4_client::cl_delegations 
list was always empty. I put an extra print to print a warning if it's not, 
but did not hit this.

Thanks,
Alex.



-----Original Message----- 
From: J. Bruce Fields
Sent: Tuesday, September 10, 2019 11:25 PM
To: Alex Lyakas
Cc: linux-nfs@vger.kernel.org ; Shyam Kaushik
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of 
a particular local filesystem

On Tue, Sep 10, 2019 at 10:00:24PM +0300, Alex Lyakas wrote:
> I addressed your comments, and ran the patch through checkpatch.pl.
> Patch v2 is on its way.

Thanks for the revision!  I need to spend the next week or so catching
up on some other review and then I'll get back to this.

For now:

> On Fri, Sep 6, 2019 at 7:12 PM J. Bruce Fields <bfields@fieldses.org> 
> wrote:
> > You'll want to cover delegations as well.  And probably pNFS layouts.
> > It'd be OK to do that incrementally in followup patches.
> Unfortunately, I don't have much understanding of what these are, and
> how to cover them)

Delegations are give the client the right to cache files across opens.
I'm a little surprised your patches are working for you without handling
delegations.  There may be something about your environment that's
preventing delegations from being given out.  In the NFSv4.0 case they
require the server to make a tcp connection back the client, which is
easy blocked by firewalls or NAT.  Might be worth testing with v4.1 or
4.2.

Anyway, so we probably also want to walk the client's dl_perclnt list
and look for matching files.

--b. 

