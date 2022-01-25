Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA649BDD2
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiAYVW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:22:56 -0500
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:30134 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiAYVWy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:22:54 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 16:22:54 EST
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 315837872
X-IPAS-Result: =?us-ascii?q?A2ETAAC4Z/Bhh7E5L2hSCBsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgUkDAQEBCwGBUVaBVmqESoNIAQGFOYUOgwIDnXUDGDwCCQEBAQEBA?=
 =?us-ascii?q?QEBAQcCQQQBAQMEhH4Cg10mNwYOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBA?=
 =?us-ascii?q?QEFBAICEAEBAQELDQ4ICwYOFSKFLwwGJw2DU007AQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBCD0BAQEBAgESERUIAQE3AQ8LGAICJ?=
 =?us-ascii?q?gICMiUGAQwIAQEegmKCZgMNIQGhIQGBEwEWPgIjAUABAQuBCIkMeoExgQGCC?=
 =?us-ascii?q?AEBBgQEhQ0YRgkNgVsJCQGBBioBgw2HHYQIQ4FJRIE8DAOCdD6EHAIPAoMug?=
 =?us-ascii?q?kMikQGBewFLLQIFJwUFDDw1AgE2oUhgnFKBLoNPn0IGDwUug3KDVY8Wil+GP?=
 =?us-ascii?q?ZZHIIIlo3YCBAIEBQIOAQEGgXeCADMaCB0TgyRRGQ+KC4QVGYNYin0jMjgCB?=
 =?us-ascii?q?gsBAQMJjWUBgkUBAQ?=
IronPort-PHdr: A9a23:rT80cBzqdPll6tDXCzPTngc9DxPP8534PQ8Qv5wgjb8GMqGu5I/rM
 0GX4/JxxETIUoPW57Mh6aLWvqnsVHZG7cOHt3YPI5BJXgUO3MMRmQFoCcWZCEr9efjtaSFyH
 MlLWFJ/uX+hNk0AHc/iZxvPvnCi5CVUFxniZmJI
IronPort-Data: A9a23:h+9ah6kS+IZQ6gk3OAXh90To5gwaJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcXmmHbviNMTD9c4p2a9/l8h4HsZ+By9Y2SwtppX1nE1tH+JHPbTi7wuccHM8zwunrFh8PA
 xA2N4GowPjZyhYwnz/1WlTbhSAUOZqgG/ysWIYoBggrHVU+EH571Eo58wIEqtcAbeaRUlvlV
 eza/pW31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOrii4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFiI5eZMkSvqkEqm8A87ko0HPNFZEZvi26opf1Om
 O5zicD3RVYFNYSZzYzxUzEAe81/FYtv3eaeZFSa74mUxUCAdGbwyfJzCk1wJZcf5ut8HWBJ8
 7ofNSwJaReAwemxxdpXSME13phlcJatYdxZ4y4/pd3aJa9OrZTrW6rN6MNK9DI5msAIAOrTd
 8MCLzdjcXwsZjUUYwpHU81uw73Aan/XMBNgqmy0/44M4Cvy6wIp4YnQNfXfU4nfLSlSth3B/
 TmZl4jjOTkQOt2SzTae2nyti+vDhi7gHoUIG9WQ+vdrmlC7ymoeB1sdUl7Tif24jFOuHtRRM
 GQK9Sc066s/7kqmSp/6RRLQnZKflhsVWt4VH+hk7giIk/PQ+1zAWTdCSSNdYts7ssNwXSYty
 lKCg9LuA3poraGRTnWesLyTqFteJBT5M0cLPCIFdQtewuPOn9EIsC6TCdoyPKWc24id9S7L/
 xiGqy03hrM2hMEN1rmm8V2vv95KjsiWJuLSzlWINl9J/j+Vd6b5PtLwswGzAeJoadfCEADb5
 xDojuDHtLhWZaxhghBhVwnk8FuBy/ueeBjbgFhiBPHNHBzwoyX7Iui8DNxuTXqF3+4BcD7tJ
 UPW5wVY4cYKOGPwNPAoJYWsF84t0K7sU8z/UezZZcZPZZ43cxKb+CZpZgib2GWFfKkQfUMXZ
 svznSWEVCly5UFbINyeGrt1PVgDm3pW+I8rbcqnpylLKJLHDJJvdZ8LMUGVcscy576erQPe/
 r53bpXWkEwEDbGmOnKLqub/yGzmy1BrVfgaTOQHJoa+zvZOQz1J5wL5ne59KtE9w/w9ehngp
 y/lAxYHoLYAuZE3AV7TMSs8AF8edZN+pmg8JisiIR6j3GI7Zpym8KYYcfMKkUoPpYReIQpPZ
 6BdIa2oW6wfIhyeomh1RcSj8ORKKUr67SrTbnLNSGVuJPZIGl2ZkuIIiyO0qUHi+ALs6ZBhy
 1BhvyuHKac+q/NKVZaPN6n3ngrv5BDwWotaBiP1HzWaQ220mKACFsA7pqZfzx0kQfkb+gan6
 g==
IronPort-HdrOrdr: A9a23:nji8bKsaXVI9N6pwGZxB08ot7skC9oMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhBo7+90We7MBXhHO1OkO0s1NCZLXTbUQqTXftfBO7ZrwEIdBeOldK1uZ
 0QC5SWTeeAdmSS7vyKnjVQcexB/DDvysnB64bjJjVWPHhXgslbnnhE422gYyhLrWd9dP0E/d
 anl6h6T23KQwVqUi33PAhPY8Hz4/nw0L72ax8PABAqrCGIkDOT8bb/VzyVxA0XXT9jyaortT
 GtqX212oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iHnz4Qe+BIr1/BdGC8phXgnyHmzTYV8nfnjWSVhHPyyPaJMg4SOo5kv8Z0YxHZ400vsJVXy6
 RQxV+UsJJREFfpgDn9z8KgbWAqqmOE5V4Z1cIDhX1WVoUTLJVLq5YEwU9TGJAcWArn9YEcFv
 V0Bs203ocZTbqjVQGbgoBT+q3vYpxqdS32B3Tq+/blnAS+pUoJj3fxn6ck7zM9HJFUcegy2w
 2LCNUuqFh0dL5nUUtKPpZ0fSKGMB29ffvyChPgHb3GLtBPB5ufke++3F0KjNvaCqDgiqFC1K
 jpYRdlqGIic1irJtaJ2Nlm4zalehTJYQjQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,315,1635224400"; 
   d="scan'208";a="315837872"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:15:47 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aztOp3T1Yzmuvzsvdpx4qqBRySKJ/EqkvJTisdBuxngLCRf62Sboo5FY+j4qxin23ixtLuoDII3OkpqO6osmbRUeSuzvGKnHzIE3hxpRzeNAVtVOyQOVMB7ptJWPLroxpH0e6a+Q+k2b1P4X8bWoVZXz+2APwu0jlPXtFJQBmhM62OyPZ/z3pr2jrGBt3V8WqNmtEPSpA0h9LyhSPP6pjctfQuIgdNXYiN4w40ZqdhNr2NbZ5/KLxIgw/L/IaV2GK8U0YgGdLcQoDa9xgJ9ZtEtsQmCM2ZQvAAJMak9IVOF0vb0h7pXIn0/DRu689IzMr/m6BHMTZqSuXVOQmueKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLDWGixtNg8PnkGLxmR/2asPbGPdrEdb5CJ2X1Bcw00=;
 b=Ii8SVtNQrNA7E1owEdic4KAGQOu1bMUo/dbXQgDk5yMsHIbL9prooxdigJWCueV7tDqXLsymccnXNgVlbVJw9udz7OIitoJzacqDjz7D4yqOCtpmhQD/hLNGR4iD+q6nhaBXOkULDvEuduPOJB2x6HNdIt5neFI/1wmTV5Y+2lUBri+Sn9pu1EVjEX8LulHDErOLiagxY1O7YLGnvOfvp6mugf/CZ9dCNzx0fwfJGNHAXNJcaT9RZbzCpJUG0fsyDIPUeruEIA5X/3Gm2x4FMHoLOJSqj49z6tRuY2mnn+UGwrPv5Ddk/iGQJ6iQ5HY4EvHL3dq5boHZLer7NYm1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLDWGixtNg8PnkGLxmR/2asPbGPdrEdb5CJ2X1Bcw00=;
 b=c1JayCQfBjYjAgq83k6g0PuqyPe3dZGGj51XkQR6u5LEpkjQWB1RrjkaGqjeuNWKRC2kA8mViqnYYP/rpAdVKAOTq3qzO/cZMSWR53/MiCq1bViddWR3hMG3IUVTPpE+1rMis+bOeVeVy5tpXkpaWyhdOc1xnpOKJbi8kwZ4Qxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by PH0PR06MB8319.namprd06.prod.outlook.com (2603:10b6:510:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 21:15:44 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::7949:fab0:e011:12f2%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 21:15:44 +0000
Message-ID: <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>
Date:   Tue, 25 Jan 2022 15:15:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: parallel file create rates (+high latency)
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Daire Byrne <daire@dneg.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
In-Reply-To: <20220124193759.GA4975@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19)
 To BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5966e905-a3f2-4527-cbad-08d9e047d966
X-MS-TrafficTypeDiagnostic: PH0PR06MB8319:EE_
X-Microsoft-Antispam-PRVS: <PH0PR06MB831960C4EB23154F8EA3627B835F9@PH0PR06MB8319.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnzjROxPB7Jsqms8diNReUG2YdQPSsMCbwAsiza1+4HBUHvucWfRJz5udzoe0QM4bmjQzSjqKtH7SLGeVZ2LUAFo0ZSryQkphtSYFktIioczQY/4Ae4ucDYOfFNzUp7/lMWQ7wVfAsBFqHe9l8EveP8jpiZHCxdXXhCDV536t4NuSOEpg8WguypwDdoYli2vn8pNQtoHTeFTqE2OFbquu4sGDgzji95gDHzeKum9f+hl/bNjT6SUKJgh0DnE2s6PdNv0ba3t7QarVnLpcFTCLe9xxJjEiIz6y+ZqXQVtIygJwYncwOVmS7F2GL7kyyuxnYFnLNVhS87KZRgaEFSL6VrCrcdYBOP9uqEpKJsJIHF6JTeoIznU0q9iOIKbyMt+yYP0VQ89jRxOE6otUjdBs71G25MJc+TNAx+7sw3NCPgnoOuUVzk1hk2gJ3yw/wmfCr/p9hckqcpsRbXYjKazBQYFL6S9I8p/Uo9ev1+E6y8MOfKTCytzUFUlx7k7IXLvCKYyeFOrbTCj8KG5Al+Tm6gTI0JlgG+ZV5swUoAKhI4x5yX2hq7dfZ8jfAmIHzRJnn+scr82yNgm96GiV2qk4WOVh0E256uYG91fH8G4U8UjpedM3NgqqbrrioIIm6rMYRdqSuh/+GfbyAGnYLRJFnkYk8RHmoYorlEl4FZ1iQIb0Z9uFQSGMHKzDMmATNxOUEO/nKZUcRkYS326zUvTcSCrXHb8ZNs/6xkB08/dU6NhTgu9peFGxOldOHqu4wVziv+A4wmWyKzzsGbQJkh3Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(53546011)(66556008)(66476007)(2616005)(5660300002)(4326008)(508600001)(31686004)(8676002)(6506007)(8936002)(38100700002)(6512007)(86362001)(31696002)(186003)(2906002)(316002)(52116002)(6486002)(26005)(75432002)(38350700002)(110136005)(83380400001)(786003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXlCRmtOd3NBRXJ6MDEycHE5aUl1VFpOMElLWDVYK0ZQUDA5QmZzejJGREpr?=
 =?utf-8?B?OWdrYXhQc0JuWDNnY3RKSzRRVW9rbkh2L0ZYbmdHa2xPTXRmNWZ2MDEwbzEy?=
 =?utf-8?B?ZlRqVGM2UGdJaUN2b2tqN2NTMWUxbjVDVkFWejNQZFFlSUEvZ1ZPOG1DYlNq?=
 =?utf-8?B?NC9YREptUnNIbjZxemZBeTVLTkc2Sm1qOTVPSmFFWER2VDRRU2d4dEIrcHAz?=
 =?utf-8?B?NkxrWUtDdkRRZCtWVWhWMmZhMzd0UEVsbEZCR3BUNklGU3loN2RHbzllb0Rt?=
 =?utf-8?B?VFFWZ1RCSytFQnF5SGFMZEtTSEhndUJQcGVOSHVueGFBamRTSEh0Nm0zTW5Y?=
 =?utf-8?B?T0dHQThTdzBTaFJEL0FqeXB2cCtYbDAxSjNKVk1KV3l5K3FFekZRa0NIK3E3?=
 =?utf-8?B?OHdPeE5YbFRydWJrTm9ZejgxNDdQZlFDTWg5bFlkazVDaW1zQjhNbEZuWll2?=
 =?utf-8?B?em9OS2YrY1RPY1QxajRKVkRrYTQ5QjJDQkRodkRVdDAyNHdiaU5BajMveUFJ?=
 =?utf-8?B?K0xVMW9uZGh3UDJ0RE1iYnNkd2Z3Y0o1TytRYXVnRzVCWlZZUUpGMjdhZ0py?=
 =?utf-8?B?RXYwdytnSURzSFQzc2F3a09TemFBV2hPeGZBaW4wa051MGgzdUR0S2dzRHh0?=
 =?utf-8?B?ZTNwWUcxMEZvZlVRUmx3Rm0ySUYwc2toY1FFdW45OFhvT3VoTmRncjZadVlt?=
 =?utf-8?B?Um9mSlRya1I5cmo4aW5tRjZBZHE2SW1tNzA0RGxGbUJ4Z0lJWUFKTW0xcUtB?=
 =?utf-8?B?ZzhSM21BVHZ2S0NQcWVJS0kvMVJDR2xzT09MYWJlOEVkelc5a1FCSUxwTVFH?=
 =?utf-8?B?Uy9xaGJnRWk2dnlZcjhobzc5eGI1VXV0dWtoVU5FZkNHMDh6N3M1b0ltNkhV?=
 =?utf-8?B?MlZhUS85Q3FYeWwwL0RiWURBV2JURkdRWlJWMm1ZUjYzS3dXVVJNVlNBMmdT?=
 =?utf-8?B?WGF4L0JraDI5RzRmT05qSDhOTDVXa25VV3JleUh3ayttZ0NYcmFiMHdqRkky?=
 =?utf-8?B?S2syRVNwTy9ENzZMZXFIK2h1YzYvYXZKRkV0Rm9qM0RkdmVIMml4MU5JNURj?=
 =?utf-8?B?cjBkRVlhRHF4RGVrNFNNZmJMVXFJcTF0Ky9RbkN1eS9vb0FybVJEVWt2L2lO?=
 =?utf-8?B?U0kxY2pXb0ZDKzRuZVBIcUZ4TmNkc1IvN25QWDFyQTBMZ1JFS3hqZFZ0ejhS?=
 =?utf-8?B?SktjcWg3cHBHaVlrOEtjbnFxQ3Y2aXp6RDdMYTVoN0R5RDZMVUZYOUN1c3RO?=
 =?utf-8?B?bzNZWnBoYWdJZWhBRTM1bDl2NDRnaS9mRm9VTUdxYmJPL1hrQmc1Q2d5QU5Y?=
 =?utf-8?B?QWM2OFBhWWpLRmc4M3F4RTZuWlM1eUdHNjl5QWhRcFdFcGRuWExBclNUSTV4?=
 =?utf-8?B?ZloxVjBUc2QxTlJscDdZZ1c5VXZjaFRqRHlpaWIvK3pHNCtqZ1dqRWxzY3ox?=
 =?utf-8?B?QWtYYy9US2pBb3d5OTBuM2tTdE1zTDUySEZKYU1Kc2pNVmcxKzA5elA2Q1BD?=
 =?utf-8?B?aDRpTy9tS2tDYlpxdmlCeVBhbVRQOVRkcnVEWStlMmwvRWZZL2hCcnZseUJK?=
 =?utf-8?B?RWt0amZ6VUNGUnhoSDlnVkoyazIxbHdpWDhycDlKMlFIVjRqdE4yK0xBaUpl?=
 =?utf-8?B?MmVJdENvQzNyejEvSHk3N2x4SVlKc3lGbHF5UFZ3KzlIVjU0YnpXWmhUMXNV?=
 =?utf-8?B?RE5FS3BKZHN3RmZZRE85c1Y0ZEs0bGtPRmNCUytqb0EwOHdIYjdSUjczTHdv?=
 =?utf-8?B?MmYwQ1ovaWp6MVIrWWxyRHFVU1ZmZ2swUFFqclYyTWxOaEhBZThBcnNtYkl6?=
 =?utf-8?B?c0t0Zmhtdk9zR1UyZVBBbGRBVWhBb0tCb3A0d3NLNHlqMStMV3FWT2lBTEN5?=
 =?utf-8?B?V0NuaHQxaU5vYlNHZWVRQ2N0aW4wa3c1dmpjUG0ydVk0VHIxM1hDbEpZaVl0?=
 =?utf-8?B?WDBQOGN0bzByYWdscTJWR2hWaGlza3VCcVJlZC9TQVdLRUoxVWxtMXFaWVJW?=
 =?utf-8?B?UHdocGd0Mm5EYWRZNXRhMDdORFZxL0xURGlGamJQTHZuTVZUU1FPQllXekZa?=
 =?utf-8?B?SmorcitJRFZTVENyK2pqdVZ2NHB0aTVFQy9NYWFvUmhZTGVUMTNwZ0YydnJK?=
 =?utf-8?B?aVc4N25mTGxYUHB4bys2WVkxbTVwNklGMC96MnBOUGpDZFY5VTFHaHBqaU43?=
 =?utf-8?Q?YnwYp1IZg9Ll5u8qmLG/6qQ=3D?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5966e905-a3f2-4527-cbad-08d9e047d966
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 21:15:44.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esDxeqMFDDuwRygT1owKUyzdGloxyuSclcKIRa/TtDOv1xhJM6CiFRo90n61256vq6yaaQmrm1RXhpjU131uwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB8319
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/24/22 13:37, J. Bruce Fields wrote:
> On Sun, Jan 23, 2022 at 11:53:08PM +0000, Daire Byrne wrote:
>> I've been experimenting a bit more with high latency NFSv4.2 (200ms).
>> I've noticed a difference between the file creation rates when you
>> have parallel processes running against a single client mount creating
>> files in multiple directories compared to in one shared directory.
> 
> The Linux VFS requires an exclusive lock on the directory while you're
> creating a file.
> 
> So, if L is the time in seconds required to create a single file, you're
> never going to be able to create more than 1/L files per second, because
> there's no parallelism.


So the directory is locked while the inode is created, or something like 
this, which makes sense.  File creation means the directory "file" is 
being updated. Just to be clear, though, from your ssh suggestion below, 
this limitation does not exist if an existing file is being updated?


> 
> So, it's not surprising you'd get a higher rate when creating in
> multiple directories.
> 
> Also, that lock's taken on both client and server.  So it makes sense
> that you might get a little more parallelism from multiple clients.
> 
> So the usual advice is just to try to get that latency number as low as
> possible, by using a low-latency network and storage that can commit
> very quickly.  (An NFS server isn't permitted to reply to the RPC
> creating the new file until the new file actually hits stable storage.)
> 
> Are you really seeing 200ms in production?
> 
> --b.
> 
>>
>> If I start 100 processes on the same client creating unique files in a
>> single shared directory (with 200ms latency), the rate of new file
>> creates is limited to around 3 files per second. Something like this:
>>
>> # add latency to the client
>> sudo tc qdisc replace dev eth0 root netem delay 200ms
>>
>> sudo mount -o vers=4.2,nocto,actimeo=3600 server:/data /tmp/data
>> for x in {1..10000}; do
>>      echo /tmp/data/dir1/touch.$x
>> done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null
>>
>> It's a similar (slow) result for NFSv3. If we run it again just to
>> update the existing files, it's a lot faster because of the
>> nocto,actimeo and open file caching (32 files/s).
>>
>> Then if I switch it so that each process on the client creates
>> hundreds of files in a unique directory per process, the aggregate
>> file create rate increases to 32 per second. For NFSv3 it's 162
>> aggregate new files per second. So much better parallelism is possible
>> when the creates are spread across multiple remote directories on the
>> same client.
>>
>> If I then take the slow 3 creates per second example again and instead
>> use 10 client hosts (all with 200ms latency) and set them all creating
>> in the same remote server directory, then we get 3 x 10 = 30 creates
>> per second.
>>
>> So we can achieve some parallel file create performance in the same
>> remote directory but just not from a single client running multiple
>> processes. Which makes me think it's more of a client limitation
>> rather than a server locking issue?
>>
>> My interest in this (as always) is because while having hundreds of
>> processes creating files in the same directory might not be a common
>> workload, it is if you are re-exporting a filesystem and multiple
>> clients are creating new files for writing. For example a batch job
>> creating files in a common output directory.
>>
>> Re-exporting is a useful way of caching mostly read heavy workloads
>> but then performance suffers for these metadata heavy or writing
>> workloads. The parallel performance (nfsd threads) with a single
>> client mountpoint just can't compete with directly connected clients
>> to the originating server.
>>
>> Does anyone have any idea what the specific bottlenecks are here for
>> parallel file creates from a single client to a single directory?
>>
>> Cheers,
>>
>> Daire
