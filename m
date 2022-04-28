Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF96513475
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbiD1NIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346409AbiD1NIi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 09:08:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ECFAFAF8
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 06:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqbaML7U6KbhTZVM2Iofx7DRJzzt0RzcnCmZ5nUGFpwhpW87y/bEm4OWlydjllZ3Mq8zzrBmBCfwzV7EBWmNNEi9jBsFWMjxhmJiUfdAu4yF2zrnoe1tzs50yg+D2yL3i1TvaJX25CcCC2T3+ijiHy7eocqpcYJ+B8tLzHTMzkFE+yXLfR2AVKthkmcUHZm+EMjjz3h6skgAIc8Q3OmMXHmJAqE43k62OeUhmw/GjpkNFl1ZaP77hk/BFrkogYvEOsSzMHSN4WoqZ42u6N4tAevN0H8HH3o3jSK9JcM9cm0U0UabMnf/6mUSjg6MDdI8iVQLH3kN8+RlvqtUCdhpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEOPbApJVg5jSbrOZRl00Kq6PulSdJQwtC79KOk3D98=;
 b=gDD71WNuIKZFp08iJg9VaW/IsIZ2OOl5F9LahMGYv8ZTsCF15OQPkY6LXHSiSOssk3mG04cXYoKJ/1iZXC7IK9udJ8OxQaR3EERa/rTRK/+fvAKWFiD/lyYrM2Sg+IhJNKHGSe0VALCbteQ8KGoUUZGlrnOflPf/ecJZD9R4huQqdKxGupJCZT7yr641esQ7kR+buZkQY9EtodrOTI06VLpLdxw4R+o7+SgagUqRJFbvMo9G1ek+9JVUrQwZzmPtdALkpOtaBoErPjavPPjtIZzsoVfh8BAr+OSbnwMHwv7PwBqyK9TAwcIF6pvjXA4gfKUkRe6a6JH5GuAl7nFB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEOPbApJVg5jSbrOZRl00Kq6PulSdJQwtC79KOk3D98=;
 b=euYtHqDINN4Smzo8Z5tqSlisL8dZhNXc3lwD6I7zcjTqRctUNhCWhRVEIze+wmlvIXQ2yG492Yo1DuTnn3sJVKvlO1vee5V+aTqxXDLsrooZWXjk5FzA6zMs2E2VQO/2fypO+PVtXg5COuhpfRYrgTi03BF/9G8Q9a3ivTbRS01LUk1TOjp/RZAZnie4YTE6mjAccNUbC3sSHUnrbkm8OALo7lX3O/OqHqU7EL3JFp4x1bysLsgVkDCuTHXtX+FoqnQfUfoOZcC75FcAIRLsMs3gkfKv+LGBNHlb8uaQJQxKMmmVd5uNPh3KmD4c+H5vyjhqaVVidg+UFTrS5IXo9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 DM6PR01MB5564.prod.exchangelabs.com (2603:10b6:5:179::29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Thu, 28 Apr 2022 13:05:20 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::7cf3:6dcb:9372:7379%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 13:05:20 +0000
Message-ID: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
Date:   Thu, 28 Apr 2022 09:05:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: NFS regression between 5.17 and 5.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 495b6da3-e66c-4caf-6de9-08da2917bf59
X-MS-TrafficTypeDiagnostic: DM6PR01MB5564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB5564B34E7DE115C34456C60BF4FD9@DM6PR01MB5564.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsQdegc27dWE0S5jDxQfCSD/bx8O2Pn4zaHj+qfQhPfdjjuSv8WWYtPW1oe2OSLbne3Hr6tTIBUQY/nvSSSK/SVMnt7me69Euj2YdcHBTKas8+TGgMQ8HqNCgkBEBDdF85lSYP5/wQ0yWrp5lFw7z+9vzVApJt6Kz0AHjBFnWuffvfIzTtFxgeTj4FXSfx1w7CVv4d49PyM3qddzv0YiDr+PlZwqg/HrOPW70dPUtYFU3VbxZ3h1aRDVuB24GcOVvDfhlQtLYQKO9P/qWHg5nB7bm7WzuAhFKFGKFahgJ6fKg38Fo72oGoTR45BrOj1bf+l4q594pQ6LDcnX0QCysFCCbZ5HNu+Q9MyOShdTKQp9b6d1b2MwPs/XmoAv+OS0zrpHiFjanTWU336wEiA7F4/QKpf8lOQUPDI4WcHtWJrXHBRAbh3kwWDLSJqpfmQ8P8Y0YAv/MLN6ePzb/Zvp3eu4twR9Y2uwdURQFMipBTx2QXnpfG9sAmrcu7HyO90iuZtmeS0JyXtZ2RrBeWThgPFnL0u3sjZkIcXOIPrWu8vbclzXPucBerUzkw+Qy21+iK/OvM7zXn9ziDw7u5QR0suxBpE2RSwC5BXvph6vujs70lng2UL4Rl5QmM+1lyeijWcb6QH9tC2Uvb8GuN4rB343j9JbUxGZoKHOjDCtFq7b2dqH2p+V63p96vYAzfjFlkx7QTTATEXn3aMMs+6Y7wYN5jRdE/1//daqTqkPFfqbGZWPjsZKzJc56hX+daQI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(2616005)(6666004)(66476007)(6486002)(26005)(66556008)(66946007)(6506007)(52116002)(6512007)(316002)(86362001)(6916009)(508600001)(31696002)(186003)(38100700002)(38350700002)(83380400001)(44832011)(31686004)(2906002)(36756003)(8936002)(5660300002)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBUUm92aHBPVk5ocllqODVsNGo0cTA4eER6VUFhOW5EZHMwTFB4aVlobXpx?=
 =?utf-8?B?Z0plUkwwSEFaVzROYzEyaWdpZEFteEZKYlRrS0ZLbGhXZkp1TzViY3hGNGdH?=
 =?utf-8?B?L0RwTDF2YS90cStac1pQV3NKUjF0SHB4cGlNdTlGaTVoakVaTlU5L0c5b0tt?=
 =?utf-8?B?N3hSMUgzMXJFL1BBaU1uak1jM1doNGQzaGRwRVQ5RVlVSmFtTXBnK1hDY1NG?=
 =?utf-8?B?Y0JkR3p2K2JtRUpCOUpaTUZmbklCMm9PQXJ3TzJVSnFmMzc2UGZTYVRiRHUy?=
 =?utf-8?B?QlRqRDQ2Y3lVYjlIaU9aRVhvNlgyNGFKMHo4U2Y2VHNJV2RwMHpYdjl1T3dG?=
 =?utf-8?B?aGlSbUZWWVArZkZDZTRjMHl3TzFFZDlUMzZiUktTK1k0SEJkNGJVSTRLbFVn?=
 =?utf-8?B?Zm5abmNiaEJud2tQRUpLTUdDMzdvY2plSUsxUks4T3k3TGkwRkhKU2FHWkV5?=
 =?utf-8?B?Rng2MFpPdkxxUjF5UG84M0JLUDFnQ1ZEUklUUlBnZytFZzZUL3F1TmMrY0dT?=
 =?utf-8?B?R2FYdEtCZ1dKamwwdG9lV1MyQWxFUHQyNElLa2RTN2dSQzJ2bjVtVitQWmtq?=
 =?utf-8?B?cERGdVViYzloYmo1NnZjUEVGR1QwVXVSU3dpUUttSlhqQjByeXhzWGlDZUNl?=
 =?utf-8?B?TU1UbVQ4bzZOaVhHU0ZZR2tXaWNDSllhcm9ubnJrTzlyMkFqWjNtWjlkRFM0?=
 =?utf-8?B?OVlhNnRubURkZEtYZjJtR3JXdmpDU1V4YkJEb21yaGxGaWp2MXlaSisxUWlO?=
 =?utf-8?B?T2xIaHd4cXpxL2JidERLRFNEZDB1QXdLM0pIUGlkM0hpOXF0b1lTYWN3SHl6?=
 =?utf-8?B?WU8rZm5Sc2IrdkpHN1phRXRJaWpjY3ZyaHE1c0F4WGRtaTExa1dhT3ErOGo0?=
 =?utf-8?B?bEZ0OUVPU2J5OU8rS0hYYUFnN0NwcG90UHcyVFpTZE9jUERnczBNa2dJM1c0?=
 =?utf-8?B?cFdsVkJFNUR1cFV0UFhNd25hdEZhT1AzYXVqNW1WelIyV3VBN3dpZGlHeEhT?=
 =?utf-8?B?eGVaN1RlZkF5Zk9aZW93eEZIZlZXY29ubE0vUUliSG1GSEVkWVVYNVhDcStZ?=
 =?utf-8?B?ZVB6VUNZRU8zQWdFaTh6ZU5RVnJFKzVobURYM1RNKy85Rm9Ydm9zZTd1UGZT?=
 =?utf-8?B?R1piOVJHeVpQWEk0czNoem1Oalg1UGhMbDRveGZtVFQwd3BoUndrVWY4RjV1?=
 =?utf-8?B?dkl1Smt3elAxRmhZeEhPVjJMK0ZPRm1pbUlLTk5BNU85QlpkQStsRnhIdlFX?=
 =?utf-8?B?TDFFT2I5TGIwdHNQL3FFOVllazZYbVFJaUpydmcvV3o1eXhEN3BmVkR6RXFy?=
 =?utf-8?B?ZnkzWmRONVZSRThIbG84eTVLSW91dTFmb2ZGYlNoYnR2dTdpV0dxYWNYTS9K?=
 =?utf-8?B?cllUK2VOb1ArREQ5OVBoTXczQmlNNTNodXVWeTU0NFJVVDQ3WUpBMzVZN1ZN?=
 =?utf-8?B?MFNZcUpHWXZ4TzdXOTNVR3pQYjVYVXE1ZlEwYnJkNUFIWlZOWDNrM255cmNJ?=
 =?utf-8?B?QmhnbFVpRisrUlo0T2toKzdyMExUMGNFQTk5SEh6VjVGNmt4VFRVTTZMN3dr?=
 =?utf-8?B?NGhxRk8rTEx4d0dNUDcxVmQrSzEzWENJblZodWNNenVKRXh2Y3lOVCtjbmZw?=
 =?utf-8?B?UG1xQmZUaStEOXZ2aXpzSFA4akxvSEZaaE9Cdjcram4zTVlpb3kvU1VlYXBQ?=
 =?utf-8?B?bzlTLy9OdGttajF0eHVLdTBIUThVTmpJWkZoMC84TXU3bFpoUU5nWDdMTG0w?=
 =?utf-8?B?VG1JemhQTllHaU1leE1rSjM2c2x1dGVZRUh1OEVTa0ltdVEva09kUVB1NEVP?=
 =?utf-8?B?WHRTWDRyL2ZuOHRKQWMrZ0NjdlNiZlZUY0hoQzhZWkRrUmh2c1BVUzFHY0dv?=
 =?utf-8?B?N2N1VlVUL2Q2VXdGUjVrMHJRQkc1eDgrZzlMVzB6ekxGVzFYaWVsa3ZnRFdz?=
 =?utf-8?B?ZktRTFBWcXZMQzR4RWl0WXZxNGY2U0ZhZGg1aGZRNUdwZDZCN2oyRXpvVXR6?=
 =?utf-8?B?bGRlNE1HbmE1TElxbHdBNDh1NDFqV3Y5THdOQ2I5c1J3aVc5YWJZUUFMNVlD?=
 =?utf-8?B?T3ROQlZ4VzhnNWRFMElDRGxBUlZSclhGNFBNTXhyVkNERGpHKzcrbWpFSTcy?=
 =?utf-8?B?dEt4UFg3b0pVWDA1UHpkOG8rUXFZd2tORXFxVWhwNkJTWGNwczErZE9mNUha?=
 =?utf-8?B?VHd3dW5ScjhRWGNKMFM3YmZxZ3J2QVFsQUZDdFVtWTBTUVFOdXpVMkJuakx2?=
 =?utf-8?B?ZmZEdkNkeitITnZLODNqY2c5dHRXbWI1KzJ0TWFoaktNV2ZsN0RZaGdTeDJn?=
 =?utf-8?B?NU1LbVJ3V1prN0ZMTE5nbFlnME5DNjRPeUJOcnQyYTlrU3FlVHhUZ1VCOFFj?=
 =?utf-8?Q?LzABbVRFFQiE1V51nLNskE5Tb8WQkSU2pxs3U?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b6da3-e66c-4caf-6de9-08da2917bf59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 13:05:19.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDjBAmlKAAX91jr8EspDE7L8jyQRNVOEZtdsuXG6sxvt/Cce0dYUZybWH/rPNRtiY+00XnE8uDynI3sbq2CqOho1ZBlRpbEQ2pm0TqfgKsmD6Wc7jux0R3IarlwplcQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NFS folks,

I've noticed a pretty nasty regression in our NFS capability between 5.17 and
5.18-rc1. I've tried to bisect but not having any luck. The problem I'm seeing
is it takes 3 minutes to copy a file from NFS to the local disk. When it should
take less than half a second, which it did up through 5.17.

It doesn't seem to be network related, but can't rule that out completely.

I tried to bisect but the problem can be intermittent. Some runs I'll see a
problem in 3 out of 100 cycles, sometimes 0 out of 100. Sometimes I'll see it
100 out of 100.

The latest attempt I have is at 5.18-rc4 and here's what I see when I 1) create
file with dd, 2) copy local disk to NFS mount, 3) copy NFS to local disk.

Test 2
Creating /dev/shm/run_nfs_test.junk...
262144+0 records in
262144+0 records out
268435456 bytes (268 MB, 256 MiB) copied, 1.29037 s, 208 MB/s
Done
copy /dev/shm/run_nfs_test.junk to /mnt/nfs_test/run_nfs_test.junk...

real    0m0.502s
user    0m0.001s
sys     0m0.250s
Done
copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...

real    4m11.835s
user    0m0.001s
sys     0m0.277s
Done
Comparing files...
Done
Remove /dev/shm/run_nfs_test.tmp...

real    0m0.031s
user    0m0.000s
sys     0m0.031s
Done
Remove /dev/shm/run_nfs_test.junk...

real    0m0.031s
user    0m0.001s
sys     0m0.030s
Done
Remove /mnt/nfs_test/run_nfs_test.junk...

real    0m0.024s
user    0m0.001s
sys     0m0.022s
Done

Create the server with a 4G RAM disk:
mount -t tmpfs -o size=4096M tmpfs /mnt/nfs_test

exportfs -o fsid=0,rw,async,insecure,no_root_squash
192.168.254.0/255.255.255.0:/mnt/nfs_test

Mount on the client side with:
mount -o rdma,port=20049 192.168.254.1:/mnt/nfs_test /mnt/nfs_test

Any advice on tracking this down further would be greatly appreciated.

Thanks

-Denny

