Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57E729F35F
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 18:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgJ2Rg2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgJ2Rg1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Oct 2020 13:36:27 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A33C0613CF
        for <linux-nfs@vger.kernel.org>; Thu, 29 Oct 2020 10:36:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 780F135D4; Thu, 29 Oct 2020 13:36:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 780F135D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603992985;
        bh=d6mk9uV3EP6tf4BJzLWCwOiByylru0ONHAkO56TE5FM=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=WKnfUhDG/N/KkSpjI7eFnrNIWOxi5AET/1qx1VNbSrqAfECp68F25OhLYbXfuf/ZZ
         DBfYTyLDkbpatzT+s2dCVzsDoXlXn4qPaVESEcQenFt4cveBJaYfVKAnqRXBudn22Y
         gVSZcPuXtpGmGz8Xcut0JTMxX+7MMvPIgOrXU+1Q=
Date:   Thu, 29 Oct 2020 13:36:25 -0400
To:     Kenneth Johansson <ken@kenjo.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: nfs home directory and google chrome.
Message-ID: <20201029173625.GA26726@fieldses.org>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <df1c5127-4e48-672f-e2c4-4ce31f146952@kenjo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df1c5127-4e48-672f-e2c4-4ce31f146952@kenjo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 28, 2020 at 12:01:28AM +0100, Kenneth Johansson wrote:
> So this is just an update to how to avoid this problem.
> 
> I switched to nfs v3 and no more issues.

Yes, that's also consistent with the explanation that the problem is
client lease expiry.

NFSv4 locks are lease-based--the client loses all its locks if it
doesn't contact the server regularly (by default, about every 90
seconds).  So, if you suspend or lose contact with the server for too
long, then you lose your locks.

NFSv3 (NLM) locks are not.  The client keeps them until it unlocks them
or explicitly tells the server to remove them all (such as if it comes
back up after crashing).  So, there's no risk of losing locks when you
suspend, but there's more of a risk of stuck locks that get in other
client's way when one client dies.

Once we implement "courteous server", locks will only be removed once
the client loses contact for more than 90 seconds *and* either another
client requests a conflicting lock, or  the server just runs out of
memory for client state.  I think that'll be a better compromise.

--b.

> Since the switch chrome
> have not stopped syncing with the google server even once. suspend
> resume causes no issues and everything looks ok.  So it's clear that
> google-chrome currently does not like nfs v4 and I need chrome to
> work more than I need to run nfs v4.
> 
> 
> On 2020-10-04 13:53, Kenneth Johansson wrote:
> >So I have had for a long time problems with google chrome and
> >suspend resume causing it to mangle its sqlite database.
> >
> >it looks to only happen if I use nfs mounted home directory. I'm
> >not sure exactly what is happening but lets first see if this
> >happens to anybody else.
> >
> >How to get the error.
> >
> >1. start google from a terminal with "google-chrome"
> >
> >2. suspend the computer
> >
> >3. wait a while. There is some type of minimum time here I do not
> >know what its is but I basically get the error every time of I
> >suspend in evening and resume in morning
> >
> >4. look for printout that looks like something like this
> >
> >[16789:18181:1004/125852.529750:ERROR:database.cc(1692)] Passwords
> >sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >[16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web
> >sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >[16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web
> >sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE
> >INTO autofill_model_type_state (model_type, value) VALUES(?,?)
> >[16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)]
> >Autofill datatype error was encountered: Failed to update
> >ModelTypeState.
> >[16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History
> >sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >[16789:19002:1004/125902.536903:ERROR:database.cc(1692)] Thumbnail
> >sqlite error 778, errno 5: disk I/O error, sql: COMMIT
> >
> >
> >[16789:19002:1004/130044.120379:ERROR:database.cc(1692)] Passwords
> >sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE
> >INTO sync_model_metadata (id, model_metadata) VALUES(1, ?)
> >[16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web
> >sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE
> >INTO autofill_model_type_state (model_type, value) VALUES(?,?)
> >
> >
> >and so on.  if you use google sync you can also check
> >"chrome://sync-internals" to see if something is wrong with the
> >database.
> >
> >
> >
