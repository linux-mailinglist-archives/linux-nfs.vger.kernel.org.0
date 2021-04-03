Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03D23535B5
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Apr 2021 00:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhDCWld (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Apr 2021 18:41:33 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:48578 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhDCWlc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Apr 2021 18:41:32 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 133MfQgW030024;
        Sat, 3 Apr 2021 23:41:26 +0100
From:   Nix <nix@esperi.org.uk>
To:     "bfields\@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9, 5.10)
References: <877dourt7c.fsf@esperi.org.uk>
        <20210223225701.GD8042@fieldses.org>
        <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
        <20210224020140.GA26848@fieldses.org> <875z16m8oh.fsf@esperi.org.uk>
        <20210401134442.GB13277@fieldses.org> <87eeftlljk.fsf@esperi.org.uk>
        <20210402192059.GA16427@fieldses.org>
Emacs:  it's all fun and games, until somebody tries to edit a file.
Date:   Sat, 03 Apr 2021 23:41:26 +0100
In-Reply-To: <20210402192059.GA16427@fieldses.org> (bfields@fieldses.org's
        message of "Fri, 2 Apr 2021 15:20:59 -0400")
Message-ID: <877dljj8ix.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Apr 2021, bfields@fieldses.org said:
> Sorry, did you say whether nfsd threads or rpc.mountd are blocked?

I'm not sure. I will endeavour to find out (I think I did look to see if
anything was blocked, but I can't remember the result: it's been a long
time now).

I'll probably do some more debugging on Monday.
