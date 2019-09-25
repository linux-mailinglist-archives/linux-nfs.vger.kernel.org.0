Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87C0BE2CC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2019 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfIYQsb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Sep 2019 12:48:31 -0400
Received: from fieldses.org ([173.255.197.46]:60650 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731087AbfIYQsb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Sep 2019 12:48:31 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3786C1510; Wed, 25 Sep 2019 12:48:31 -0400 (EDT)
Date:   Wed, 25 Sep 2019 12:48:31 -0400
To:     Kevin Vasko <kvasko@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Message-ID: <20190925164831.GA9366@fieldses.org>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 18, 2019 at 06:36:13PM -0500, Kevin Vasko wrote:
> We have a new Dell EMC Unity 300 acting as NAS Server that is
> presenting a NFSv4 NFS Share. Our clients are mostly Ubuntu 18.04.3
> but issue is also present on CentOS 7.6 systems. We have been
> struggling with this issue for over a week now and not sure how to
> resolve it.
> 
> 
> 
> We are having trouble with NFS Clients completing their writes to the
> Dell EMC Unity 300 NFS Server when Kerberos is enabled on the NFS
> Share. I created the NFS Share on the U300, associated it with our
> FreeIPA (Kerberos/LDAP server) and everything shows successful.

Troubleshooting ideas off the top of my head:

It might be worth trying some other client versions if it's not hard.

It'd be interesting to know what's happening on the network....
Unfortunately big krb5p writes won't be fun to try to capture and
examine.  Maybe some network or rpc-level statistics would help show if
there are an unusual number of retries or failures.

--b.
