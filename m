Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AC3F5118
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfKHQ32 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 11:29:28 -0500
Received: from fieldses.org ([173.255.197.46]:36364 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfKHQ32 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 11:29:28 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id EFA611C19; Fri,  8 Nov 2019 11:29:27 -0500 (EST)
Date:   Fri, 8 Nov 2019 11:29:27 -0500
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Samy Ascha <samy@ascha.org>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Specific IP per mounted share from same server
Message-ID: <20191108162927.GA31528@fieldses.org>
References: <5DBD272A-0D55-4D74-B201-431D04878B43@ascha.org>
 <CAN-5tyF7F4Mc8Z-bwg+Rq-ok50mchyF+X24oE8_MZzVy8LRCmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyF7F4Mc8Z-bwg+Rq-ok50mchyF+X24oE8_MZzVy8LRCmw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 08, 2019 at 11:09:10AM -0500, Olga Kornievskaia wrote:
> Are you going against a linux server? I don't think linux server has
> the functionality you are looking for. What you are really looking for
> I believe is session trunking and neither the linux client nor server
> fully support that (though we plan to add that functionality in the
> near future).  Bruce, correct me if I'm wrong but linux server doesn't
> support multi-home (multi-node?)


The server should have complete support for session and clientid
trunking and multi-homing.  But I think we're just using those words in
slightly different ways:

> therefore, it has no ability to distinguish
> requests coming from different network interfaces and then present
> different server major/minor/scope values and also return different
> clientids in that case as well. So what happens now even though the
> client is establishing a new TCP connection via the 2nd network, the
> server returns back to the client same clientid and server identity as
> the 1st mount thus client will use an existing connection it already
> has.

So, this part is correct, it treats requests coming from different
addresses the same way.

Although you *can* actually make the server behave this way with
containers if you run nfsd in two different containers each using one of
the two network namespaces.

There are also things the client could do to distribute traffic across
the two IP addresses.  There's been some work on implementing that, but
I've lost track of where it stands at this point....

--b.
