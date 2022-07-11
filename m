Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64282570C8D
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGKVOV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGKVOU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 17:14:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749122314A
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 14:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr2IxfLP21zeXYVCnUOZWrKlcET1sxsw5Nh9VLSyY+uMiu6jU5jiOhXmd+UYSuyIZQIfMtlB3C66nK4ZGy85mMDxVRrgQrDESBbyBfC1sGpOZr+4oipmOLnQDUifwD8UhNtI8g6Vpdy+GsIC4SBuAsz5voT07niuvhNxCPc7pxqurSVgIBow73CRJ9DwHPwSUlmewcKb2Qdkv1LCvUM+le7zB5pa4TCARdX+cV0CqUH8UcltN+A2ozDcWprthnNzJdyLsUzWmRVQ59ASGKu6hxElmXYU4LO+42yikl3ub0KvYxAlXc7ZIOtULJ4SytSnvkOpeXz/dR7XGGSrbV4dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1xQhNXhTCvgcra6V7s4kjPLi/f6RYGmGgmS/JpPxzY=;
 b=N+pNmEcRtxYojZzoJhF/GgdFuoCk0ogLrLbq1BhQ56LgJ+QPQIPonz/Vc4Cnxqkip+cd0xjj6TJGEGhAvJQNMHVjomkTH96qGFj3fQE0mNGJTzAsdpYHaWD/arGTHyunSATznvYnRR+2AvejNnbKmXj6dGRiLuHsI77ZoZtyy0J0BuKsE6q76gMBFkYR/OW/AZAyRHfq8oFQRYliV4DcnkhWsRTo8BV+M0putSnvfdHPzOMnQa/SzLYB/hE4aEtjrKGbEdgjG5N9dASfbYSXKOrvjUQ87HuztwNQ3Tq1vlIhT0K9FvRaSX6urNAyN5oYmE1ZDlI8vyqhQW1CZxF12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BYAPR01MB3941.prod.exchangelabs.com (2603:10b6:a02:91::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Mon, 11 Jul 2022 21:14:09 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::e1f2:b518:f502:3cac]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::e1f2:b518:f502:3cac%4]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 21:14:09 +0000
Message-ID: <76588a2d-9f53-6347-48b3-5fd45a69cf99@talpey.com>
Date:   Mon, 11 Jul 2022 17:14:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
To:     Rick Macklem <rmacklem@uoguelph.ca>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
 <89044942-DAFE-4E9B-BC70-A8D2C847A422@oracle.com>
 <24C858F4-5334-4417-BFA5-4D580274F47E@oracle.com>
 <YQBPR0101MB9742865EA5C7945107B76A8DDD879@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <YQBPR0101MB9742865EA5C7945107B76A8DDD879@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8a8515-275b-446e-e6e7-08da63824b84
X-MS-TrafficTypeDiagnostic: BYAPR01MB3941:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iucUWU3k9YuJwoYsN/8y2xKd6sFU4KqqRI+dkTV5mm6Ud2R70YNowZJmCu9OzwwRxgU+VCW22uEnfg/WJmFwrHADom6ItDKbbRJoV9wdgRFJtnMEajWAuvHSyCmwDDVBYj90Z5spGANdB0DdEa85MYg1Zen3yCFsxoWJKq2rw1K7TtiEcFCXR8ZNdPH16z62ZQb427CQHu17ge3yMIFUipBIKliRwvkvSMU3PhtjT2K6XjofB4Ixs3HzDyrg7BsPLsYmVmBHMILmElS2LvF8hpKjm4gxncpX4KsfSFIRE5xnTRyR1dsYbHU2j19Ignh26WmZsEApRGaLOeLOZ089vDk9zWzMt3qXD/yWgTT9VP2PaVK8z3GkB21ciS8B9jnC/HDjdNMdDYn22foy7emH17C9oU5uEJgZg9wjkeGOU5TgW0xqqJ6o/tLY9wqQ6dr9sA5OnDj7yxLSsLj2lLEZLE4adN1+/0Cg3EvCVR/tuiLESxgN6lQ2TgzbVozmBxyyWuJou2zyfCxYFigBs0rHUqYJ28m72buOkPW0waj2fwMYkNotQXeI+VgW+sNvLXbHWJDaqwoZQ/l+BkkPsEUPDsLjmzeTMm6iXpimSagR+gsdYTbwDOnuolbauu4AWhx+2EJkYH2GtmPl9h9qzz7c3c9YiP/BCfiP7TBW/AEeZmefK1d3jKn8Bh3ZyCRzOOKJBCLPvZIN3+GLM8f/72414AJJVY6djXb0e3yv4CrupAJ0LRj0pEQCqFF+lAr+BRKIVqLBoRRLBaeLRJZGLobSHUOz+h42CZl3zXPbNaXWzzOjeDUTpwmM+XodVdHh2Gyc2DItMbCnqG3O+yKoMLkRGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39830400003)(366004)(346002)(396003)(136003)(53546011)(6506007)(38100700002)(52116002)(8936002)(316002)(41300700001)(4326008)(66476007)(6512007)(26005)(83380400001)(31686004)(8676002)(66556008)(38350700002)(66946007)(2906002)(86362001)(31696002)(5660300002)(110136005)(2616005)(6486002)(186003)(36756003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVqQkpKNkt4KzVscWRkV0RWdU85ejlqdlNjMkVTYWRPY0VLaXcwdmRsS0wy?=
 =?utf-8?B?UjBIWkZwSEZYZDgrakx6V2sxSWUzSkltOGxGZ3VDOXhaWHoybHg3QXlCZTNG?=
 =?utf-8?B?OVpETjZ2VnJVL0RRWnBHLzZpbVl1aUQxaGtJRzJwV0JJdjdvaUlwYUUvbmlZ?=
 =?utf-8?B?WjRMSHE1WHRpMHpoZE5OMWxxYTlkZmhMNlRpL2daaCtTWVg3b21jKytGOE9l?=
 =?utf-8?B?enV6K21Vb3RHR2xUT2MxNm5SRktJc0NsRTB1S1NQY1BMYi9hVzRWdzBjMlBS?=
 =?utf-8?B?b1IwdTdXU2RQTU03WlQrNFBDY2hCZVlRWU93cUVuVWlUaWl1WDhMbFVEWlBy?=
 =?utf-8?B?ZVIzeWFUSHpQR2RBWGdWNlg2NDkrbU1HL3lTa2tjMjUwV1V4bUpuQ2dnYmxH?=
 =?utf-8?B?am02cHJWcERpVXB2RFhFRFd5SzZGSWMvZm9tbDZ4bEV5YlFyMi9KNWRtZUpS?=
 =?utf-8?B?d0Z5c3p2WVNVbFpHcE5BM0FQVFBZelBrS3pzTWg2T3FTRnVMOWJScVBrYi81?=
 =?utf-8?B?WXpKazRWSS9jM1BoSmlwRTVqbGJVK3BuNVFlZDI5aGdVMVZDcEFDVlFIUWNm?=
 =?utf-8?B?WjZSTVdicVdSUzY5ejh5QWdJWis5K0d0MTRLeEd6Ly9Hd0pIVUo4VVlieWRW?=
 =?utf-8?B?YVU5VWwwUzBzbmxpcTZKK2pKcTIrWDJOeXNFc2RNUDZ5TyttbGdDM3hCaTh6?=
 =?utf-8?B?bnFabjFpUzBzaXNMalFrM3FyQllSZmVTSXZnMkhnS1JHWjk0VnkreEQ5QkN6?=
 =?utf-8?B?WnRyQ0lhU1kvYXNGNk11UWg3Y3VOQ21oYjNwYjRvUmxhTkQxWkxzU3VBM3lE?=
 =?utf-8?B?Z0VZU2dqQWxjUE9qL2doWEVMNnNXOEd1VUs4ZVFDRnRvYldScllzT1pFd3lS?=
 =?utf-8?B?MnpsbU51UUsrUEpSN0tDQ2tucGZiRHNEbmZnR1Bhb0VFZ3QvVFd6ZWFqL0hh?=
 =?utf-8?B?UXJjSzhkWSswZ2xtMGl0bll6dnJpQTBxZUttMmhPcjJJbCs2YU1nTEVOajVX?=
 =?utf-8?B?OWhjdVpzNzFNckRuUzBoYmdVY1Q5TzYzTEY5b1VQS2NaMVVKeFNqSUdETWlD?=
 =?utf-8?B?Tmk2RWF1ZzA5K0l0Rkd5R0pMa25mZklWQ1paSmhJOHpENGVCUVFvZHBUUFVi?=
 =?utf-8?B?b1JMdzczK2crRUhjNFVNUmt0aUlrcWlyN1VRWUp5SVU1SjNhQmM3MnNoTEVL?=
 =?utf-8?B?VENpc21ZS3VDVWdTeDlMdUVBL2xLRThCdTVNZytNdlduSUZFSUdJb0ZpYVUz?=
 =?utf-8?B?citpZ0ZPdm42ZXd4aHE4WmZHRWJhZmpvcmxTTnhpSnhUYUpNcmttNEdqYTJN?=
 =?utf-8?B?RWJjMzVtSnRqU2ZaUGNabkdJYXJDdHBjbXBtR1FjK2FXbUtFOHU1eittVHBl?=
 =?utf-8?B?ekRTeXI0b2Frc3huSEdZdHNhazdybmNmREJQTk4yeDRtQktib0VGN1BIbTlF?=
 =?utf-8?B?cmlOdy90MU9UWVdhUGtOUnZZcVduMTg1d0h2MGpLb21oU2tnanUyUy9RQTh4?=
 =?utf-8?B?VEUzSEdxdUI2Qm1uc29xbjhJRHhoanNtUnJlZzlwL0l0M29TcC91M0dzVkZa?=
 =?utf-8?B?OEg1dmFBUHQyUDBDcnpzb1NieDlZZzh1M3Y1Ukd3R25sTkFvYVgrT3VNbVFi?=
 =?utf-8?B?ZS9hNFNiSDFsd1dEZkhGYm9SSkJJbEJncDRXUlpuOWcyQnFIU0tTVm95RTdG?=
 =?utf-8?B?T1ZGQnc1T2ViWDhoUS9zcXZ4cm9WUGR3QmtpMm9DTEoyNFU4aWlQbEcwaGlm?=
 =?utf-8?B?RURmYW5qTlV2ajBUYkJEL3p5QyttSnk3aHZNbkR0N3BLdE84ZVh4aE92QVhq?=
 =?utf-8?B?NE9CN2JJTXJpSnMvS0grSE5MQzduVEdVd25OUVd6b1RCVURqUys0bWlGdDFX?=
 =?utf-8?B?d2VKQS9pTHNLbmdKTFovV0Z0QmRTZlpSck1iOG5yaEg4ZkpROFBmSUdvTHNh?=
 =?utf-8?B?MURlb3Q2VzhDbUM1MHNxOFlxZUpmYnUzY2Izc05KMmpmV25XV1ZJL1dlVllW?=
 =?utf-8?B?UThwckZDbEZrclgzMTIyWTkxN04vRTFwOE5UODRCUWFlblhpWWlWOENXWGRP?=
 =?utf-8?B?Qjh6bFZURHNQdEhLWUJtUmpFQmRCbFZrZEZKbHptL29PQ05TdGM5SWl6MmpN?=
 =?utf-8?Q?rtJY=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8a8515-275b-446e-e6e7-08da63824b84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:14:09.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6iAaa/MhuHs3fyDy9KLj0c0QdhBtPwZ7PiT2SAzhtDe1SKFt3Cg93RM8tyY/EdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3941
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/11/2022 4:43 PM, Rick Macklem wrote:
>>>> CREATE_SESSION has a built-in reply cache to thwart replay attacks.
>>>> It can legitimately return the same sessionid as a previous request.
>>>> Granted, DESTROY_SESSION is supposed to wipe that reply cache...
> Well, I just re-read the RFC and I don't see anything that says DestroySession
> affects the CreateSession reply cache.

It actually does, but I think it's problematic:


18.37.3.  DESCRIPTION

    The DESTROY_SESSION operation closes the session and discards the
    session's reply cache, if any.  Any remaining connections associated
    with the session are immediately disassociated.  If the connection
    has no remaining associated sessions, the connection MAY be closed by
    the server.  Locks, delegations, layouts, wants, and the lease, which
    are all tied to the client ID, are not affected by DESTROY_SESSION.

What about the reply to DESTROY_SESSION itself? I guess the idea is
that if the client misses the reply and reconnects/retransmits, it
gets NFSERR_BAD_SESSION and figures it out. Maybe not worth taking
to IETF, since you found the root cause!

Tom.
