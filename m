Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB83B3902
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 23:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhFXWBY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 18:01:24 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:33762 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhFXWBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Jun 2021 18:01:23 -0400
IronPort-SDR: SA38J5KTx1CmVzfZD5Rg0kQ9IdRXX4Lgix3cHSQYDc4w/kZxEfNvLT/WKBXbqWGCmPa31/2APe
 NjFIa1R/NpoUAeQxht53Niv6pftJH439miQnXLfQOIzWTmctubafYU/89sWUjIOq5hfuTbajc2
 iIX5CiA2oikzekZyZ0DrZSbulrhTqfeUHj7XXm3ESF8KyqhQL7u5k3Y9fieR2dVOZuQh5+Hmir
 TpVk06a35aFDXvlN+g/SfUorYDIQBiBNMkLbheDRQDxcKx3v0zSvHg94QPXik5OTJj+/SgLAso
 nbY=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 284701815
X-IPAS-Result: =?us-ascii?q?A2EHGgAm/9Rgh21GL2haHgEBCxIMQIFMCwKBUVGCQAuEP?=
 =?us-ascii?q?YMCRwEBhTmISy0Dmh2CUwMYPAIJAQEBAQEBAQEBBwI/AgQBAQMEgVeCdAI1g?=
 =?us-ascii?q?jwmNwYOAgQBAQEBAwIDAQEBAQEEAQEGAQEBAQEBBQQCAhABAQEBbIUvOQ1DA?=
 =?us-ascii?q?RABgwFNOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCg?=
 =?us-ascii?q?Qg9AQEBAQIBEhEVCAEBNwEECwsYAgImAgIyJQYBDAgBAR6CT4JWAw4hAZoDA?=
 =?us-ascii?q?YESARY+AiMBQAEBC4EIiQx6gTKBAYIHAQEGBASCT4JcGEIJDYFZCQkBgQYqA?=
 =?us-ascii?q?YJ6im9DgUlEgTwMA4JtPoQsgy+CZIMBHzI5gUtJTjMvA55FXJxsgymddQYOB?=
 =?us-ascii?q?SaVDZBqlQxWnygihQUCBAIEBQIOAQEGgWqBfzMaCB0TgyRQFwIOjh8Zg1eKf?=
 =?us-ascii?q?FU4AgYKAQEDCXyGW4MaAYEQAQE?=
IronPort-PHdr: A9a23:a+AgAhyY0ZEic//XCzMvngc9DxPP853qMQMPrJkqkbRDduKk5Zuxd
 EDc5PA4iljPUM2b7v9fkOPZvujmXnBI+peOtn0OMfkuHx8IgMkbhUosVciCD0CoMvHndWo5E
 d5EWVsj+Gu0YgBZHc/kbAjUpXu/pTcZBhT4M19zIeL4f+yaj8m+2+2ovZPJZAAdgTOhYfVvM
 BimpB6Xu8UL0uNf
IronPort-HdrOrdr: A9a23:X8ySm6kzRCtvRiaM6Dv/RCe/h2npDfOnimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcIi7Sc+9qADnhOdICOgqTP2ftWzd1FdAQ7sSibcKrweAJ8SczJ8R6U
 4DSdkYNDSYNzET4qjHCWKDYrUdKay8gcWVbJDlvhVQpG9RC51I3kNcMEK2A0d2TA5JCd4SD5
 yH/PdKoDKmZDA+ctm7LmNtZZmNm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYZ93
 TfmQCR3NTsjxj78G6c64bg1eUUpDLT8KoAOCVKsLlRFtzYsHfpWG2mYczHgNl6mpDp1L9gqq
 i1n/5pBbUJ15qWRBD4nfKl4Xic7B8+r3Dl0lOWmn3lvIjwQy87EdNIgcZDfgLe8FdIhqAL7E
 rat1jpzaa/ICmw6BgV3eK4IC2CV3DE0UYKgKoWlThSQIEeYLheocgW+15UCo4JGGb/5Jo8GO
 djAcnA7LIOGGnqJ0zxry1q2pihT34zFhCJTgwLvdGUySFfmDR8w1EDzMISk38c/NY2SoVC5e
 7DLqN0/Ys+B/P+rZgNcdvpZPHHQVAlbSi8Tl56EG6XZp3vYUi91KIfyI9Fld1CVqZ4sKcaid
 DcTV9IvXR3dFnpDYmDzZsjyGG/fFmA
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,297,1616475600"; 
   d="scan'208";a="284701815"
X-Utexas-Seen-Outbound: true
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 16:59:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuZVhFJtRuK64/V7R32iBO7qKsfmNv054gDVQuBYcazqA82RMHzCh9SxOwFBAYu46wCpewKA48abfHpNp12BI/Ehuhogh4m8zSedq3zTxB3T8NyVNoOyMhsgvYMa/qrsRhZ23dKzq1gI9cdt4vRn8g3s7odsKMtEpE/bLXzxhUiNk4vF4djLN4IVr0lmxZlCNAYIepv/soiAd8UQaRZ8MYWiNudv9nSSglu/ZzCXuhNMZdDyZVw0HOQhCR3o+FuDQ/l45CWvbcDhw56G7htne8EATnct4mPIQzNlBNPLKS3v1uiKMCpGEh1SVlF75WA0aTnTRb1JpsmDKXpzh4+A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ReqyiobGj1s39pTr+UOX1dMmjphi8TRgGjnfawAQL0=;
 b=LjrR5adlcKlaQuecIcACdUNMs6MQN8tf+6mdH5uPqe8N+76Zod21rcK0QeLEDp9yKRdDuRgRiOX9EkybB78OCVV5Smk5BmKSx+6JDRvXy/UK3geyA6W5MkjG6aLoV/tENiwvMjYaemmkvzB0KtpB8rLx4IJcnGW/GZSouZo/jfXd7Wg8hq+9PzXnl2ZaDWREYkMnRKriqfr/4Z7A2KOQF/cGxijj4j2PZQ/gsFmGrJU24RStsPTbFxsOl9hMIaQf1G9XBldzeThKb+nBbPq9u9sFIwNgenRQJOTgF7o1ikpJatpMDd/Gbag9QmiUZhZSWeaby9aQ4n3ZaGHQWyk/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ReqyiobGj1s39pTr+UOX1dMmjphi8TRgGjnfawAQL0=;
 b=NdozVCHPRbLYiB9blxNsIYDq9/B248LUkK8YgDlrvkA3/IYJk16cB5Fw8Ee7WuW/ID1C1cokpdO+NphhAunSN5LZ9JXkTm11TvYMfpvZh4XCY0KrDLPUfEWVzn4fuN5PGAHh8k+hQYQcEQIjytuheCU73hHdW/GWNrICmw/8f5Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB5206.namprd06.prod.outlook.com (2603:10b6:a03:c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 21:58:59 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22%3]) with mapi id 15.20.4264.019; Thu, 24 Jun 2021
 21:58:59 +0000
Subject: Re: any idea about auto export multiple btrfs snapshots?
To:     NeilBrown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
References: <162432531379.17441.15110145423567943074@noble.neil.brown.name>
 <20210622112253.DAEE.409509F4@e16-tech.com>
 <20210622151407.C002.409509F4@e16-tech.com>
 <162440994038.28671.7338874000115610814@noble.neil.brown.name>
 <20210623153548.GF20232@fieldses.org>
 <162448589701.28671.8402117125966499268@noble.neil.brown.name>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <3ac9c4f3-6bc2-9753-6f0f-937aa4f13efa@math.utexas.edu>
Date:   Thu, 24 Jun 2021 16:58:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <162448589701.28671.8402117125966499268@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN4PR0501CA0104.namprd05.prod.outlook.com (2603:10b6:803:42::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 21:58:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ff719f3-7546-43a5-bd8f-08d9375b44fe
X-MS-TrafficTypeDiagnostic: BYAPR06MB5206:
X-Microsoft-Antispam-PRVS: <BYAPR06MB5206DBA45198C65035BE0F1583079@BYAPR06MB5206.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfV8D4PWsGl/JXhOz0XfN1fHHtXDC94NE+/Fy1bQBQ/QzUHqM623uIwxBDw1sZFsDFDQqcgom5upTh8JX+R4e0YFaP/wIl0xSOKmlkYWOre8FxcoCePaHuyWKZeeTeZnvmdw6LZbLsyCMbS03bEBRj8VcYOm6DzppwR1Am3Dzfno9Al17fAW+eNUnOKKHo/Io5mWqDIgPM7g6AKjre0Hg8nAUhRYDYlLTfcJcXHYnH48yT0mjSRIFXlwh8lAyJRzy3YF58ME/IjMGloUluC+PP1/KmouCtfnpgINtlu312wSeZr8XgXssNbzyH4QcRN57mbGfomMqEzzKmh5ujgJPtPaRZxOGulDapIvGtm1VPlycWKPuzg51SZ/gD/ZpXh2ViY+2c5CKPp2d+OftGIzL2WrSgJhxB1fmg/wB6yF3//sNHJqQFld7uNq6m/okak7mfFZ78XQpe/B+JjJJYR/wzuOVfE/iuu29L+z7ep03PZbABdoALwqkDiVACUTo6bgW1fax9V2mDVS9c95eaIXsE372vOcSJnIPw3zmmSBo2TdXI2lxeHJkmRTWLXZoSfmdAQt8tmKyZoGmnKrdfIIiYaEPH7wxWtWjLn+JIXMGooh2L1IOEPotpYp8OqYCPqnfuSfBz5ivWARi3lji55Y9Y9P0A7HQUO9cdWss0+XOZdGVnPODZLAe5UctGiy1l7NccUmB9igCocQ8vxSpFju/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(38100700002)(38350700002)(16526019)(186003)(53546011)(786003)(5660300002)(2616005)(956004)(110136005)(316002)(16576012)(26005)(2906002)(52116002)(31696002)(86362001)(83380400001)(8936002)(75432002)(66476007)(66946007)(31686004)(66556008)(8676002)(6486002)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnorY3JDSldGdGdzcVdVejNQSURlbEQ3V0FDVEJNbkY0OWp4M0ZCWE95WFBn?=
 =?utf-8?B?WTV1ZWlpZnJvVHBvRFZpWFJwVjZabTZqZkJYdHl3N0p0eG1mWFdUV1c1Wnhx?=
 =?utf-8?B?djJ0MUFocUR0NFFMRG9IV0RReTg2OHRUV3lNcjBPUW14SndiOXcyaUpVK2I5?=
 =?utf-8?B?cjFQZ3A2N25IS0hTYk5yZlk3TXE0RXlJVnhDWEQwUUhlTzlUWUhnZ0hac2JR?=
 =?utf-8?B?V2N6TWQxTHJIMFBhSzNFQmljR1F3T2x5ZldObFBmRlEyanpBV2QyRG1FVDFj?=
 =?utf-8?B?TEdQT1FkR25TdkFqUWVuWjhqMFNmM3pxa3dpYlJBWThUYnRlOEVVNnRlNjJn?=
 =?utf-8?B?eGUxdzZvc2VSRkhUSlIzeDBhd1dxTFpVSGNyeXJsQkM1d2h2SFp1WSs2VEZS?=
 =?utf-8?B?OXA1U2p3bjkrakJHUWJ6RjlHYUxjOHdWTFFJUm5QNEVzM2h2NFZNZWZoSW5t?=
 =?utf-8?B?OE9ZeUEza0JUVFF6eDJDaEpHSFhvZEtTSndPaU0vcm1JeDRXZElQMWhNR2xL?=
 =?utf-8?B?eUIvS3RBUDN4VXc5S2FXbDRSeGZCa245RHlVaUlJWUIrSWZMVFI5ZWx3Y3lQ?=
 =?utf-8?B?VG8zVHJISUFmRDZsTis0RDE4NE9TRmc4aUhBM29BbGt2NHI4MFB1MzROUHpx?=
 =?utf-8?B?WEtneGdLNnlYRjUrdm5aLzhTOEdmdUJpVU03NHlRQngvM3dGeU9uR0JYOWdo?=
 =?utf-8?B?c09Ka2tBTGk3QzZxMURUYzVlODhIanNET1k5cmcxVFE0bGhibUFWVitKVFgw?=
 =?utf-8?B?MnZNNmdNWHpmSDlZVWNWYUR1SkhFUU1naDIxeWlnSHBhUk9SLzdiYTByVk5x?=
 =?utf-8?B?N3dLOVJlQ09yR1VJWW03OG15VWhweXliNVNVS3BNWWovWk9iWER2VUx2VVBQ?=
 =?utf-8?B?VjZpV2JwcklMSExyVU15MmdEb1RCdmYzUnJDT0FpcWg2b01adnZJSGFsY3Ez?=
 =?utf-8?B?NlErQnhyOUQxRFZZQzBVaW4wUXhTUVJRc2JRL0NNenE3QStPTW56OUx1eURC?=
 =?utf-8?B?UXNZMm5yVXFBMFpleWVsY1RsYUtlM29lbmVNeG5Gd3R3L3ZrMHhBQ2JrZVU0?=
 =?utf-8?B?WVhwQTB2aHdtcFNacmRlYmlablhOd2gwM29kRVk4MncwbVZtZ2d3RWFTcjJJ?=
 =?utf-8?B?aFpsNzErM0RMYnVuRnhJMWw2QmJ5ZmF4TUlKT2dlODNtU1ZFRk9WYjQxeVpj?=
 =?utf-8?B?M01Ba0loNVRmOCtpWWo1UU5kaTNXajYyVjFCYzh1RmJ2TExPamYyTis4UHJr?=
 =?utf-8?B?N3Z0dDV5ZXc2S0xHcHdOeGFFeWxJUEQyanhGU1lIRUZzM0Rla2Y1MjJoOFpV?=
 =?utf-8?B?QWJKeHJGcFlGMDdVZlhDbWYrUWlLeFN0eWxiSm10dDFGRGZ1VlFsYXd3UUpt?=
 =?utf-8?B?YjR2TlZNU2lDZmVtdGhxU0RJRlVFQ0RYMi9kTzJoS0tleWk5N1Z4QnhuSFBM?=
 =?utf-8?B?RWNFa3hpQXFIemJQMVpRL1ZBdW52ZGt5WW5VK3pZVk9NeGJtQy9admVLeUY5?=
 =?utf-8?B?cWcyMUF6QjYwenY2S1B0aWVlcTQ4SUx0T055S3pJRlIwc1FYa2gyaGNGVGdu?=
 =?utf-8?B?YlFxalB2Z0dNSkNaUytKRkhrSEpSK3FyaEthWHp3REE1ejFxZU4zM2loTmMx?=
 =?utf-8?B?VXNpV0JrV3NOQXMrdEoyZFIwc25wZE45NWtaTVFUVEgrbEhkbEp3Sk1aSXRr?=
 =?utf-8?B?V2M2amRJTDFSdkFDUDhTcHFHbE9yM1lkeXo0V3dORU1obTU3VmNjbG9YbkR3?=
 =?utf-8?Q?/F7X0h674iyEZxl8cki/oUDqMiqKzuvDqYIwhmW?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff719f3-7546-43a5-bd8f-08d9375b44fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 21:58:59.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wwPqxtIpG/6qSzr87TSSuwK4wqUI6lOdYVWS+MmDa7MIzZI2wMWQmJ8fQ/zge5k7s5pPG4uWBJaKdMshPS13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5206
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/23/21 5:04 PM, NeilBrown wrote:
> On Thu, 24 Jun 2021, J. Bruce Fields wrote:
>> Is there any hope of solving this problem within btrfs?
>>
>> It doesn't seem like it should have been that difficult for it to give
>> subvolumes separate superblocks and vfsmounts.
>>
>> But this has come up before, and I think the answer may have been that
>> it's just too late to fix.
> 
> It is never too late to do the right thing!
> 
> Probably the best approach to fixing this completely on the btrfs side
> would be to copy the auto-mount approach used in NFS.  NFS sees multiple
> different volumes on the server and transparently creates new vfsmounts,
> using the automount infrastructure to mount and unmount them.

I'm very confused about what you're talking about.  Is this documented 
somewhere? I mean, I do use autofs, but see that as a separate software 
system working with NFS.


>  BTRFS
> effective sees multiple volumes on the block device and could do the
> same thing.
> 
> I can only think of one change to the user-space API (other than
> /proc/mounts contents) that this would cause and I suspect it could be
> resolved if needed.
> 
> Currently when you 'stat' the mountpoint of a btrfs subvol you see the
> root of that subvol.  However when you 'stat' the mountpoint of an NFS
> sub-filesystem (before any access below there) you see the mountpoint
> (s_dev matches the parent).  This is how automounts are expected to work
> and if btrfs were switched to use automounts for subvols, stating the
> mountpoint would initially show the mountpoint, not the subvol root.
> 
> If this were seen to be a problem I doubt it would be hard to add
> optional functionality to automount so that 'stat' triggers the mount.
> 
> All we really need is:
> 1/ someone to write the code
> 2/ someone to review the code
> 3/ someone to accept the code
> 
> How hard can it be :-)
> 
> NeilBrown
> 
