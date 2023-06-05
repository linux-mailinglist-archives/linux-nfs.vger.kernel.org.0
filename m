Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC687227A9
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjFENmW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFENmV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 09:42:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5227A92
        for <linux-nfs@vger.kernel.org>; Mon,  5 Jun 2023 06:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOdP2guQadP0LTqhOdTz5TGVlx+SQYIyZijjPdbdFAP/jYvs7ZOfNSViBqbFB+LqQZCq+lq0XCHCT2MJJRIbwRQriCJPzYaSWMPQYtowe6JSaY0NqjFZIHmWhNaHLwtqx6DXsx5LFiDinQ4FE6M/bI9qGb28q4va6uENe9uEP5jkU0hD/eYaygxoSsWS97o/GezcxEwNBKm5SkBnZPNbIlM6++GKgReJJiiHpb4ubd62EALZMzywPnTwVbBOuYafDRLuEKfyCfSl/lNz2jc1dn8GHMCUpo2vJjaqpif2s6Et227uYMpEDvR9M5amtyOMQSIKTO6FQTfBpIalAw1R7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE72y0cytJVLUSh2KjiZVvE5Oeq8gIXUmg8UefmLkOI=;
 b=Uue6AcEWYtVHKry0KNN/oaLTvA66Oz/RaDcBueL/V5NxX0JHCx7eUoyDfqJ7bCgkwqoqyU83XskXwq5QkpndaybcjdQD+XoJVlCwrlFrR9fhhBj1XMf2mMpEc+efBRe4Q4Y7UIg0Cj2LQg5uui3DncVZZ2392t9kqihGM2+5wusPhxZi9qKiI5ciflznCsgCM2DrKkisvYQvEQ+ShRGV6HGvkedEcr2/mEgtXG8y3nFlhi3ilaEt9QIVDe/En2qwhFn1HUxI/G5Q3Yg0GeL0QHvAzohEInoFhj71WHwguU3/ys/WHqp1UEVf/NAzomYhbPlQM9pO0bBJi5LDSE9uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MW4PR01MB6353.prod.exchangelabs.com (2603:10b6:303:72::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Mon, 5 Jun 2023 13:42:16 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:42:16 +0000
Message-ID: <59c63640-2f46-54fd-00bd-3730cf2e6483@talpey.com>
Date:   Mon, 5 Jun 2023 09:42:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] NFSD: Add "official" reviewers for this subsystem
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, bfields@fieldses.org
References: <168597075880.7827.6268299078653725756.stgit@manet.1015granger.net>
 <168597076526.7827.11325261490687801622.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168597076526.7827.11325261490687801622.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:208:329::14) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MW4PR01MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: dd795091-ecff-4ed3-eb00-08db65caad23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0nOnysFPU0/naRuvbSkERKX+GpBr7yGnfPnfAeUciZxgrsTNiiUkeoSk5dIpz7GNs8PnhPsrfJqExXz6Ip7gOICXxUr4F1yCMyepvIqNe/om+H8I4tjFtnNLvyXPriDSj9KyXAF/+0ryeF8DlR9INweoFjo0/Ptg38JdpLyMjuGEtxwasJiosP8LchoM/Rs+iccOjCbCb5kodxD06neqSzEVUn+J+U4CFDG85l8ndXqqQEhzXFAAO99nwSo/QaXRed73oj+5CZ+bqjxtm9dif8BtEarShRbXYcYuWxAJkHNPxJAdHO+PHGFODwdP6l1eW6mbhfXOjbg1kHrIfkRw7Z+elnD92nwJNMlzGlepqUsbtnXA9oI8psutlTXdLDJuzVw9yZ9Zz3KsZRhUEbmNQqdRFaBjXJeANwwwgxMk3auu3+SFnNVprTk7/HA4DdsdFOgzJ1cGbs7Agbahtrn3hEvMbysxc92o45ExYpUBxBMXnqA2IX2MzK8/HXKh0TWkA5q3vMC/Ut8msjq2PnIhSmf8oVoI0jYLA44Xgr8i9RW5XWHg9KQXtxXZOvYwdbxu4KEB5LjX8LReTI2ZnHkzbKJ1YcnMslqm1Z13J3258s2RCGn8HklaldMeHGq/fXX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(346002)(366004)(396003)(376002)(136003)(451199021)(478600001)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(38350700002)(41300700001)(2616005)(186003)(83380400001)(966005)(6666004)(52116002)(6486002)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(5660300002)(2906002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0hjRC9XTjhMd0RmZE5sdHhyRlI1NDBuanBmcnlGd2JSOVp6OWNmNmpPcmYx?=
 =?utf-8?B?Q21BUVpsMEgvN1VoaGUzVnIvblhzelBHZGZjajl3WVljQ1hHU3UvVElrVzU5?=
 =?utf-8?B?LzNhSlIyZDlUdytjZGJLRHVOZ1MrQ0IxVU1lRVh4czRNM1kxR0Q5YmowcERi?=
 =?utf-8?B?dDRZZFVMZnM2TitROWJhODJoUGV2OUMvcEF5ZnlWWlZMNnhjZXdqUUhJWjBI?=
 =?utf-8?B?NW0xQTVOZFNWcGZkclhYTjc2c1FPSWZtYXBYMzNjTzZnRllYQmdSVnpVa1Va?=
 =?utf-8?B?a2s0U1htc1NuZGtRU1JPd096TTBRY3lmWDFjMWE2cmVKdGtpYmtxeExJcnhF?=
 =?utf-8?B?QVNUMkdPbkhiZUg3Smk4OXdYSUY3N0pNVmlWRHY4bDU4dm0vNGFST3Y5bndP?=
 =?utf-8?B?cHZzaVJ5ZG01a2NCbEc4bW5KRjhMcEV3aGpYZEpkL05pMkRjNk0vdjNmV0xm?=
 =?utf-8?B?bG4wVmR1WFEzTUt1TEhtZEpQZ3lzRGErcVNhbFlZbHBLamZ1SUppNFBsT3hx?=
 =?utf-8?B?Ly9LbFEyL1RBNGl2bXZqbzAyT2t5cFV2TEZaVmQ0Vml6OFkwN1RRS0hZa3VN?=
 =?utf-8?B?eGpqb0dodlZrWjREZEIxNldCcWhXV2IyMk5Jc0dpWjA4TXB5RUY1b2RWRUN6?=
 =?utf-8?B?Tm15R2gvSElkcFYwUHR1VE9yUkxXTjI1T1Bmc09BWDN5TTlCQjZaQk5pZVkw?=
 =?utf-8?B?SHp1MzJ0a2tGVHdibUZwRkZ1b3IxckkyZjB3aEQ5TlBMWWdjdWRnc1puTC9R?=
 =?utf-8?B?MWVVU2gxVDdzVTI1ZjdBVW1jemVySWtNNmFFTG04cC9MRTlSdFdhWmpuYUs1?=
 =?utf-8?B?U1l3VnJVenFnb29hemQ0WXZCbXVwVDNmR1pTTDBzb2JURWI0N0ZudnlpQ3ZL?=
 =?utf-8?B?M1RyN2RsZWk4Y2J1UG9QeitCREJ2U21BcXhjYjdiVHRIZHM2Rlg2Q25uakQ1?=
 =?utf-8?B?a2N0MVRHeXhYRmxlZnNPcW9ReUdwSHpjWTl2TjR4REVMMFc2eVlMa1N5ZWs0?=
 =?utf-8?B?K01iTVB5cUgxMjZGWEFaSkVzNXM3V1Z2enZWV0pKczJMS0tDSXRoVmxYRmdJ?=
 =?utf-8?B?RnVpYmcwS1hzZkUxclJSSUtndFBkUExPd1B0WjJrcHNpSk1VbFZ1ZWpSL1dy?=
 =?utf-8?B?V0kvZWJVb3JrbTJKaVQwUUMzR3hkZjZLQjJtQ3dobldScUdYcEY0YWVuMGdt?=
 =?utf-8?B?YWNHdjdpOWR1MHNMTU1hNnBqRFhXUTJjclp1R3dvK2NwWExVRE1tTUFvc01Y?=
 =?utf-8?B?eTA0aVo4L1N6RC9rUkdLWGtmMWFuSGFnOTNWTnJnK3dWSGoxQ3JORzBWYkxO?=
 =?utf-8?B?WXR1SjI1OTdlbG5vTWNkb01JQTFpT0NXUjJBY0dFdm5pcG50ekRLVVJ3Mk1F?=
 =?utf-8?B?a1BhdU5zZGJuWDYxRDZpcGhxU0w3cElOSGdPSWFENlJ3b3BBK3Q4L3F2blBm?=
 =?utf-8?B?bnpyQjg3SmRSZmhmSjY1dDZhMWRvaHNqSkpEemNrbjhTTUNIYXJiZzRQcXBN?=
 =?utf-8?B?N3lENGltcDhuV3lvNzY3eUlxa1pqbFVUYkNlc3FBQlRnRGJuU3lJTXJjcUJB?=
 =?utf-8?B?TGZQTWZsRUI4TG9UZHZJSDFHRGh0ekNNb0ZhOE95dkh1cHE1TkVZeDg2ZHZL?=
 =?utf-8?B?UERGNHhSQWVQVitwRTVjQ3F2aVlZeVpDcEUyNnQvL2k1YjFxWnE0ZFhYVEVj?=
 =?utf-8?B?YmNQclRobGlsem9CVVpqNnhFK2paY2g1ZTNZeDN4Z3NFLzk5bi9CckRCQzhq?=
 =?utf-8?B?Y2oxTVQ2TkdNTWVhbXh6SlkyZnpTOGVRNGZxSk9MaGNlRWhDa2FNVHduNkJV?=
 =?utf-8?B?ZHJsYWxDYlFsdW9RMGRaZFZ3aDZyYlBCb3VRZDJKTGp3ZlpzazdRVGgwUXFD?=
 =?utf-8?B?OGxwemNQbHVmWHZKU0JtQkRmUm8xU1NTMngxTFlFTkxqSm9TekJtQU91Nkh0?=
 =?utf-8?B?R09QT3dtaTI1bGlDdVdPdzFxNFgyR1A5YzYwR3kxVEljYUVIa2ZsTHdicWxS?=
 =?utf-8?B?QytuczkzYm1nYUpjQjVseFUyQWk4eXZJam5PUDl0M3hmOG41ZHdJN2xlZ3Rq?=
 =?utf-8?B?ME5mNXQvbGYxWmMwWlZCSE9lKy9jSzYrYkRSbUlMN0FuN09ueWlncE94dUZY?=
 =?utf-8?Q?axqok5wrtRHXWk4uM9eQuImvk?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd795091-ecff-4ed3-eb00-08db65caad23
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:42:16.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6JO9ggCieRCTZ/DBIZJzZmqEcMHq1boOZ94DhAuJ/gH6sCMonnlnjECZjadMOUE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6353
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/5/2023 9:12 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> At LFS 2023, it was suggested we should publicly document the name and
> email of reviewers who new contributors can trust. This also gives them
> some recognition for their work as reviewers.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   MAINTAINERS |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dab9737ec16..a44d0707754f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11264,6 +11264,9 @@ W:	http://kernelnewbies.org/KernelJanitors
>   KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
>   M:	Chuck Lever <chuck.lever@oracle.com>
>   M:	Jeff Layton <jlayton@kernel.org>
> +R:	Olga Kornievskaia <kolga@netapp.com>
> +R:	Dai Ngo <Dai.Ngo@oracle.com>
> +R:	Tom Talpey <tom@talpey.com>

I'm happy to review, primarily as relevant to RDMA support.

Acked-by: Tom Talpey <tom@talpey.com>

>   L:	linux-nfs@vger.kernel.org
>   S:	Supported
>   W:	http://nfs.sourceforge.net/
> 
> 
> 
