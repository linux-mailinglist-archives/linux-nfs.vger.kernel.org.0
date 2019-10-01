Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D964C3F00
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfJARud (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 13:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJARuc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62ED3316D8C4;
        Tue,  1 Oct 2019 17:50:32 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-117-193.phx2.redhat.com [10.3.117.193])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11F1860619;
        Tue,  1 Oct 2019 17:50:32 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2F0B412017D; Tue,  1 Oct 2019 13:50:31 -0400 (EDT)
Date:   Tue, 1 Oct 2019 13:50:31 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Subject: Re: [PATCH v7 00/19] client and server support for "inter" SSC copy
Message-ID: <20191001175031.GA3099@pick.fieldses.org>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHGq=4AiMuST1kqkZWOfijvuR3bUNChL+KaNnUN900cdA@mail.gmail.com>
 <20191001171355.GA2372@fieldses.org>
 <CAN-5tyHRKu-pYAvhW0f+t4SoDs1iMCuu4JiBaNFnZmUXso4wag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHRKu-pYAvhW0f+t4SoDs1iMCuu4JiBaNFnZmUXso4wag@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 01 Oct 2019 17:50:32 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 01, 2019 at 01:47:22PM -0400, Olga Kornievskaia wrote:
> On Tue, Oct 1, 2019 at 1:13 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Sep 30, 2019 at 03:06:11PM -0400, Olga Kornievskaia wrote:
> > > Have you had a chance to take a look at the new patch series and have
> > > any more comments?
> >
> > Honestly, last time I checked I was having trouble finding things to
> > complain about--it looked OK to me.
> >
> > But I'm not sure I understood the management of copy id's, should I
> > should give it one more read.  And then agree on how to merge it.
> 
> Let me know what you would like to discuss about how copy ids are
> managed on the server. I thought that cover letter plus commit
> descriptions talk about how copy stateids and copy_notify states are
> managed. Do you want me to cut and paste that together here? Yes I did
> skip putting the same summary in v7 as I did in earlier submissions.

You did fine, I just need to read it carefully and make sure I
understand.

> > I was thinking maybe you could give us a git branch based on 5.5-rc1 or
> > 5.5-rc2, Trond (I think it's Trond this time?) could pull the client
> > ones into his tree, and I could pull the rest into mine.
> 
> I do have git space on linux-nfs so I could put my patches there.
> However, I'm confused about the ask to be based on 5.5-rc1 as we are
> still on 5.4-rc.

Whoops, sorry, just a typo, I meant 5.4-rc.

--b.
