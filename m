Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD571053BD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2019 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUOAu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Nov 2019 09:00:50 -0500
Received: from sonic301-24.consmr.mail.gq1.yahoo.com ([98.137.64.150]:41674
        "EHLO sonic301-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbfKUOAu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Nov 2019 09:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameritech.net; s=s2048; t=1574344849; bh=ruW4UFXxVsMKbdPMnmxDaTv+16pA7U93ISteQk0ZEwg=; h=Date:From:To:Subject:References:From:Subject; b=MPvA1WvRNLOnH/18318OUo8zf0/NHBjWhq1ZKtcopYYcgHTMaY2GO/dMm2Lq4WChgdTJ4zWAoLREuZwx18oBE8M5e0wirCum2WW6FjP7HzMtBBuqAY3JM4iOkVJgQfBtU4VB7L/8gIHLlvKXfA/PTJ/GeJ8A1O57ME8kq/P94umHZYFs0PC+Fo+n2AhrrUoIB3H6wjw73HhwYrsW4RFv2CuB+EJ7DAu5gD716LOTUeJll0EQwLkPEzlabh5d4tkzpq79AJ0ZM1AjjrPuVa8X2Ea/gObp5d5ZZHXiPwImCyeotRVhW/qIl7VkWJ1rptmTMEL0aIItNfMMRn9kCaxsLg==
X-YMail-OSG: Zl3iX1AVM1k6J6DISVdB1gf09zrVE.aXSFHZ2thIr6zjGWtzaWdCPQp..thz4bW
 rykj5dEl.hvedmnF0kplQ0F_oAop6IgdONyKzNkP4K6NYJkRt31XZbVA0Jy1jQRDfDPpdJW1beI8
 wIRYdw2cW6C.U7Oa9iPtLX4cv081JnQKbnCzNSC9Ypw6SOoUymNeR0C6WIs1MikY.a7kqOhVtpuG
 MawlNxFyljltqGZDRiUf1eQ6uDLnJAS8KK6d.RtTPySQ.qU58Ica9qlWF3TfGXDPHKYYSY7umHqV
 0jz7I5_ieC7AZBPjtA_MLjjO1KrNIShNpKc._f9ttp5AQfVEch7KlL3N9fp.Sj8vJ1skp4AsN.dS
 zKq7B.MqwhvOWWxbSCDfsO0zBE_5XMGtQorpoABGEce5FxWWykzmUETab9jIuP3cTFmTEJ7VyRZj
 sGo81VKneBDM6uT4kXsAGg8v9M4ilNU50lY3hV4eMvb1c8oiIrLUFJzRvjCQImYRddrqlEoct.Yl
 edggiKDJtCxi.f8WJ.j5o8aVhRT7hMxcPuawtUDsDwbFcoX.VCZKXFzWDWci7GzKrxkf_SVbOBqZ
 EClgaEsgtJbYisVY8E7LVAAAwtrMFDonBFTuYR.SKn5.EpifVLA3APzzjuK3DralLcQtnR55hFod
 2wQYXTIettRF_dECnOMlTIo_OKVNgj8cm.wMiS1hGE30TUUA.21m96j7wLKsg4bhqQTcnmD_v1.v
 FJIhcV0ZAS2aJVEtsLdkOo0.6HmxeRc_Qz0t98GBh52VRiVSbWsuftCN8fbhq9J8G2cshD8U1vF.
 .FF2woQe2MWGaY5eRDzVw.R7QBR7agV927ZpVfV.J8GigBxxXQb7.57jv6jOBZh6uuI2ViZAysVS
 EOOtUMQ2KkL0HrH186ygLohecJW2oTGdZn0jEkb9OPoL.stUkoSKd4QXpd0rA5qwFePaaUdV7VGx
 CryV1N._tdVGUOd9ctLigORQmRqzFsUttrGvwDXDvFrubXyu.h__c4fdvC.ZF.NEiBWxcW3gHQOi
 SYRzGXUYRqSytJs31Ecozdhbw_8rVqu0lmtzt64p39gTlCyn3mWh7J0vmJ_DAGXUWpVvXoRjy9t7
 EtaCK3fA.77FYUJthURLxqDxgB1zuwURBPM8RPKm1V1BTv7a5e1ymo8DZqltWQHsDjqrMxk4Y6ZG
 mkTMp5Hxp1yEEvEvzchFV9g6UPah5Zuu52tcV5mIQUf4HmSFqD6OUjU6sTbl.m30YxJ2tyAv9ppt
 hfz65aZ6Z5HG4cjFjRciS1aza4P0yQlTIxfHoLqa.x2AggQatW1ZUv5ytFbNhwVL1Pwh64YzkVZR
 TBTEadk9lXWlNnoh9R7ET3kZ2gmQWqyS3l0DXiHsdcHwq1nur2DbNWh0K5PE5NQuwS7dZ1l6CnA3
 jvjLcqgP5UyQy
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 21 Nov 2019 14:00:49 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a5d3fe49ffa08f8c15e5e7f36a770829;
          Thu, 21 Nov 2019 14:00:48 +0000 (UTC)
Date:   Thu, 21 Nov 2019 09:00:40 -0500
From:   Fred <heitkamp@ameritech.net>
To:     linux-nfs@vger.kernel.org
Subject: help
Message-ID: <20191121140040.GB9271@pc1lin.fred.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
References: <20191121140040.GB9271.ref@pc1lin.fred.org>
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

help
