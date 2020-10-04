Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1C282A8E
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Oct 2020 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJDMIc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Oct 2020 08:08:32 -0400
Received: from h-163-233.A498.priv.bahnhof.se ([155.4.163.233]:35826 "EHLO
        mail.kenjo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgJDMIb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 4 Oct 2020 08:08:31 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2020 08:08:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org;
         s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GL2Hf40wA7qDi+oHdKlsqhN8In7nUF9fnHrUF8oY4Qk=; b=iVUEFWfDkKzCe1459iYy7C37oC
        Vhz2yfOaiHVgI9qXvxnE6p19Av16a6p8DEffOJoMvaAv9do4eedPH3hI+bEk7JURK/c4FA2nOX5to
        egKkSMCfb9wkkIgZ3psu8wfHY4/YR84zOJTr/jyb7vZAqDOviR5LrGVHUrOPriTo81sI=;
Received: from brix.kenjo.org ([172.16.2.16])
        by mail.kenjo.org with esmtp (Exim 4.89)
        (envelope-from <ken@kenjo.org>)
        id 1kP2ZZ-0007Tn-QR
        for linux-nfs@vger.kernel.org; Sun, 04 Oct 2020 13:53:01 +0200
To:     linux-nfs@vger.kernel.org
From:   Kenneth Johansson <ken@kenjo.org>
Subject: nfs home directory and google chrome.
Message-ID: <0ba0cd0c-eccd-2362-9958-23cd1fa033df@kenjo.org>
Date:   Sun, 4 Oct 2020 13:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

So I have had for a long time problems with google chrome and suspend 
resume causing it to mangle its sqlite database.

it looks to only happen if I use nfs mounted home directory. I'm not 
sure exactly what is happening but lets first see if this happens to 
anybody else.

How to get the error.

1. start google from a terminal with "google-chrome"

2. suspend the computer

3. wait a while. There is some type of minimum time here I do not know 
what its is but I basically get the error every time of I suspend in 
evening and resume in morning

4. look for printout that looks like something like this

[16789:18181:1004/125852.529750:ERROR:database.cc(1692)] Passwords 
sqlite error 1034, errno 5: disk I/O error, sql: COMMIT
[16789:16829:1004/125852.529744:ERROR:database.cc(1692)] Web sqlite 
error 1034, errno 5: disk I/O error, sql: COMMIT
[16789:16829:1004/125852.530261:ERROR:database.cc(1692)] Web sqlite 
error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
autofill_model_type_state (model_type, value) VALUES(?,?)
[16789:16789:1004/125852.563571:ERROR:sync_metadata_store_change_list.cc(34)] 
Autofill datatype error was encountered: Failed to update ModelTypeState.
[16789:19002:1004/125902.534103:ERROR:database.cc(1692)] History sqlite 
error 1034, errno 5: disk I/O error, sql: COMMIT
[16789:19002:1004/125902.536903:ERROR:database.cc(1692)] Thumbnail 
sqlite error 778, errno 5: disk I/O error, sql: COMMIT


[16789:19002:1004/130044.120379:ERROR:database.cc(1692)] Passwords 
sqlite error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
sync_model_metadata (id, model_metadata) VALUES(1, ?)
[16789:16829:1004/130044.120388:ERROR:database.cc(1692)] Web sqlite 
error 1034, errno 5: disk I/O error, sql: INSERT OR REPLACE INTO 
autofill_model_type_state (model_type, value) VALUES(?,?)


and so on.  if you use google sync you can also check 
"chrome://sync-internals" to see if something is wrong with the database.



