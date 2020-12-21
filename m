Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75582DF7E5
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Dec 2020 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgLUC4P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Dec 2020 21:56:15 -0500
Received: from fieldses.org ([173.255.197.46]:51700 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgLUC4P (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 20 Dec 2020 21:56:15 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 21:56:15 EST
Received: by fieldses.org (Postfix, from userid 2815)
        id 70E977B71; Sun, 20 Dec 2020 21:46:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 70E977B71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1608518779;
        bh=5JE9TJllW3bfzd8TtKpTM/aSWIBfxU6Che9CmbiwEvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0re/AWPw4KF5LTGHYH4rPhMIDrf/IEP5uG0dN4CLrgA4Vux3e/OD2FKvarq7ar/r
         u7ymt+T2oCIWJhZjJV5Z/PAPHbxjtRCba6AI942UEMAEbPNVcSkzIvG7rDCOQniUuZ
         M6DnUx3DORFdt49toNfThyGo8BV3zVyTNMNf4384=
Date:   Sun, 20 Dec 2020 21:46:19 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Thomas Haynes <loghyr@gmail.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [pynfs 03/10] Close the file for SEQ10b
Message-ID: <20201221024619.GE24298@fieldses.org>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
 <20201217003516.75438-4-loghyr@hammerspace.com>
 <20201218164325.GD1258@fieldses.org>
 <C99E0C08-FEC2-4F5A-9467-7B96CA8E51F2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C99E0C08-FEC2-4F5A-9467-7B96CA8E51F2@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Dec 20, 2020 at 06:42:55PM -0800, Thomas Haynes wrote:
> 
> 
> > On Dec 18, 2020, at 8:43 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Dec 16, 2020 at 04:35:09PM -0800, Tom Haynes wrote:
> >> 
> >>     close_file(sess1, fh, stateid=stateid)
> >> 
> >> +    # Cleanup
> >> +    res = sess1.compound([op.putfh(fh), op.close(0, stateid)])
> >> +    check(res)
> >> +
> > 
> > This is giving me:
> > 
> > SEQ10b   st_sequence.testReplayCache007                           : FAILURE
> >           OP_CLOSE should return NFS4_OK, instead got
> > 	              NFS4ERR_BAD_STATEID
> > 
> > probably because the file was already closed just above.  I'm not sure
> > whta was intended here.  Reverting for now.
> > 
> > —b
> 
> Ahh, that close is not there in the branch we have internally. And since git took the change, I thought it was still good.
> 
> Backing out is cool.

Oh, I see what happened, thanks for following up.

--b.
