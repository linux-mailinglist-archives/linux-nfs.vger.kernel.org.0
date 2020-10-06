Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D797B28516C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJFSOz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSOz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 14:14:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F7C061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 11:14:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 52FAE4EE8; Tue,  6 Oct 2020 14:14:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 52FAE4EE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602008094;
        bh=iVA5FIs5/J42htxb55cdWnMyAFxn79IqFHIL7AVpquo=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=opkbqllasuM1fNp7WW8kYuzjA94Gdtdgm9VRNgdaSkpxufdtQh9I5+jyJaUcZCKrj
         YwoWLbjR2wPHRlUtcB1sTcWMmAJcIksibLqyLNnd4fiuKUlsOnwJoezeOf9+maGNgP
         oCTDei3yL0N7IMJgAhGY3/sy9mSxgD0K3KWeOnqU=
Date:   Tue, 6 Oct 2020 14:14:54 -0400
To:     Kenneth Johansson <ken@kenjo.org>
Cc:     Patrick Goetz <pgoetz@math.utexas.edu>, linux-nfs@vger.kernel.org
Subject: Re: nfs home directory and google chrome.
Message-ID: <20201006181454.GB32640@fieldses.org>
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
 <5326b6a3-0222-fc1a-6baa-ae2fbdaf209d@math.utexas.edu>
 <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923003de-7fcf-abee-07a2-0691b25673d8@kenjo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 05, 2020 at 10:07:56PM +0200, Kenneth Johansson wrote:
> On 2020-10-05 18:46, Patrick Goetz wrote:
> >We had a similar problem with Firefox, most notably with Mac OSX
> >users who have NFS-mounted home directories. There's an
> >about:config solution for Firefox; namely set
> >
> >   storage.nfs_filesystem: true
> >
> >This forces a specific network file locking mechanism which makes
> >sqlite behave better. I'm guessing google chrome has something
> >similar.
> >
> Since I have used chrome for years without any problems my guess it
> that its something that changed with nfs in my setup.
> 
> I did a strace and the first -EIO I get look like this
> 
> fdatasync(94</home/kenjo/.config/google-chrome/Default/Login Data>)
> = -1 EIO (Input/output error)
> 
> then the same thing happens for other files like
> 
> fdatasync(83</home/kenjo/.config/google-chrome/Default/Web Data>) =
> -1 EIO (Input/output error)
> 
> fdatasync(74</home/kenjo/.config/google-chrome/Default/History>) =
> -1 EIO (Input/output error)

Are you using soft mounts?

(What are your mount options?)

--b.

> 
> 
> 
> 
> >On 10/4/20 6:53 AM, Kenneth Johansson wrote:
> >>So I have had for a long time problems with google chrome and
> >>suspend resume causing it to mangle its sqlite database.
> >>
> >>it looks to only happen if I use nfs mounted home directory. I'm
> >>not sure exactly what is happening but lets first see if this
> >>happens to anybody else.
> >>
> >>How to get the error.
> >>
> >>1. start google from a terminal with "google-chrome"
> >>
> >>2. suspend the computer
> >>
> >>3. wait a while. There is some type of minimum time here I do
> >>not know what its is but I basically get the error every time of
> >>I suspend in evening and resume in morning
> >>
> >>4. look for printout that looks like something like this
> >>
> >>[16789:18181:1004/125852.529750:ERROR:database.cc(1692)]
> >>Passwords sqlite error 1034, errno 5: disk I/O error, sql:
> >>COMMIT
> >>[16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web
> >>sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >>[16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web
> >>sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR
> >>REPLACE INTO autofill_model_type_state (model_type, value)
> >>VALUES(?,?)
> >>[16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)]
> >>Autofill datatype error was encountered: Failed to update
> >>ModelTypeState.
> >>[16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History
> >>sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> >>[16789:19002:1004/125902.536903:ERROR:database.cc(1692)]
> >>Thumbnail sqlite error 778, errno 5: disk I/O error, sql: COMMIT
> >>
> >>
> >>[16789:19002:1004/130044.120379:ERROR:database.cc(1692)]
> >>Passwords sqlite error 1034, errno 5: disk I/O error, sql:
> >>INSERT OR REPLACE INTO sync_model_metadata (id, model_metadata)
> >>VALUES(1, ?)
> >>[16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web
> >>sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR
> >>REPLACE INTO autofill_model_type_state (model_type, value)
> >>VALUES(?,?)
> >>
> >>
> >>and so on.  if you use google sync you can also check
> >>"chrome://sync-internals" to see if something is wrong with the
> >>database.
> >>
> >>
> >>
> >>>>This message is from an external sender. Learn more about why this <<
> >>>>matters at https://links.utexas.edu/rtyclf. <<
> 
