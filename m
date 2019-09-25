Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF3BE61B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2019 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbfIYUHY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Sep 2019 16:07:24 -0400
Received: from fieldses.org ([173.255.197.46]:60862 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbfIYUHY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 25 Sep 2019 16:07:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C12F9150F; Wed, 25 Sep 2019 16:07:23 -0400 (EDT)
Date:   Wed, 25 Sep 2019 16:07:23 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Kevin Vasko <kvasko@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Message-ID: <20190925200723.GA11954@fieldses.org>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org>
 <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
 <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
 <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 25, 2019 at 11:49:14AM -0700, Chuck Lever wrote:
> Sounds like the NFS server is dropping the connection. With
> GSS enabled, that's usually a sign that the GSS window has
> overflowed.

Would that show up in the rpc statistics on the client somehow?

In that case--I seem to remember there's a way to configure the size of
the client's slot table, maybe lowering that (decreasing the number of
rpc's allowed to be outstanding at a time) would work around the
problem.

Should the client be doing something different to avoid or recover from
overflows of the gss window?

--b.
