Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D752329CC81
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Oct 2020 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507473AbgJ0XBc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 19:01:32 -0400
Received: from h-163-233.A498.priv.bahnhof.se ([155.4.163.233]:46196 "EHLO
        mail.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507458AbgJ0XBc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Oct 2020 19:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org;
         s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=v5xK9tCTnBBNZqDx0s3uy+VePVQ0lsAtfHgxXz3DHmo=; b=WnvW/JkK4ZKmWMCTxSuAyPft5P
        oWDycHAjyvxIeI+JOqIMa2JCm8WSSK1Ujkc8sb03u0XLE02bWkR9LgF9liYktOJf5wuN2TAWB64OA
        8J+nIIo34V2+Y+5NoQSv458hIWtBzHDqe0gTIxjK6JHSNBMsFDvCvqMn3yP7DehTwOZw=;
Received: from brix.kenjo.org ([172.16.2.16])
        by mail.kenjo.org with esmtp (Exim 4.89)
        (envelope-from <ken@kenjo.org>)
        id 1kXXy4-0006Uc-Dd
        for linux-nfs@vger.kernel.org; Wed, 28 Oct 2020 00:01:28 +0100
Subject: Re: nfs home directory and google chrome.
From:   Kenneth Johansson <ken@kenjo.org>
To:     linux-nfs@vger.kernel.org
References: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
Message-ID: <df1c5127-4e48-672f-e2c4-4ce31f146952@kenjo.org>
Date:   Wed, 28 Oct 2020 00:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

So this is just an update to how to avoid this problem.

I switched to nfs v3 and no more issues. Since the switch chrome have 
not stopped syncing with the google server even once. suspend resume 
causes no issues and everything looks ok.  So it's clear that 
google-chrome currently does not like nfs v4 and I need chrome to work 
more than I need to run nfs v4.


On 2020-10-04 13:53, Kenneth Johansson wrote:
> So I have had for a long time problems with google chrome and suspend 
> resume causing it to mangle its sqlite database.
>
> it looks to only happen if I use nfs mounted home directory. I'm not 
> sure exactly what is happening but lets first see if this happens to 
> anybody else.
>
> How to get the error.
>
> 1. start google from a terminal with "google-chrome"
>
> 2. suspend the computer
>
> 3. wait a while. There is some type of minimum time here I do not know 
> what its is but I basically get the error every time of I suspend in 
> evening and resume in morning
>
> 4. look for printout that looks like something like this
>
> [16789:18181:1004/125852.529750:ERROR:database.cc(1692)] Passwords 
> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> [16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web sqlite 
> error 1034, errno 5: disk I/O error, sql: COMMIT
> [16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web sqlite 
> error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
> autofill_model_type_state (model_type, value) VALUES(?,?)
> [16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)] 
> Autofill datatype error was encountered: Failed to update ModelTypeState.
> [16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History 
> sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
> [16789:19002:1004/125902.536903:ERROR:database.cc(1692)] Thumbnail 
> sqlite error 778, errno 5: disk I/O error, sql: COMMIT
>
>
> [16789:19002:1004/130044.120379:ERROR:database.cc(1692)] Passwords 
> sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE 
> INTO sync_model_metadata (id, model_metadata) VALUES(1, ?)
> [16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web sqlite 
> error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
> autofill_model_type_state (model_type, value) VALUES(?,?)
>
>
> and so on.  if you use google sync you can also check 
> "chrome://sync-internals" to see if something is wrong with the database.
>
>
>

