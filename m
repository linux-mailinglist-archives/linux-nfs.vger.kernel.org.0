Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F99604A9D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJSPHK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJSPF6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 11:05:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01348E9C
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 07:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKTU5J7/u+daslZOVsMj1ubDGc/TRy7AapJcx09LKRBU5ZmLLlE5nBjmLTBzIAF2U7btGxoOTUrNwSKMoG6e4IRofxi5L8JfDjzQrIIolbdcWRNFJhVShF6E/UocsaX47eHd2UfT9vbfUfBNqNb53+DmPyy51D6mkIptASv/EcxzYk9KbPx0jwRVC/0ZzKnykNQ8V2EPRdlFGlj+aIYX6+wV3RWrPP3yvOtGDojauV9fzWtGW6oQaRC8Rg30Y7/mpZn9wlbpxFx/iv0GR+/nS/ORHagvJRuwk8pZ+kniCz/z+WwNx4rdioomjn8oRaoMwnzmaimybR6IKwKfQUm7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCT4Om8LCkScVps1jz1HxaFt+Q651TFvLHw8VSxtfJU=;
 b=jUIVTSux8uLz1EEQsUDz/ZvEsIttdbsmzEEjRkMuPptGd5bG6jnocd/GoTvnlo2gf4sGD9l4zbEDpjqFXGtfaV6eznpNTLdCJkeI32W2bkM7jqGmP/b13VD3xewh4A4jsgqhneYg7eLNJ4B4T2HH6E9qErWRH5eU5uWK3iXCg8B7Vah8dFq5l/cHPkiw0odZV+z2lHzTqUgTBnYmz6QLCsFR9FnFo797/KcsLySV1PZTDRZGmE4qUldPxUdOkUVO/7cJkUzBM+gtJbmGIDTioMr8z65sZyFbvJvsxvNzXpw+ElOdSFh4n9fZNBIGoaNivU10Q44o47cbIT/rZun1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BYAPR01MB4438.prod.exchangelabs.com (2603:10b6:a03:98::12) by
 BYAPR01MB4373.prod.exchangelabs.com (2603:10b6:a03:9c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Wed, 19 Oct 2022 14:58:57 +0000
Received: from BYAPR01MB4438.prod.exchangelabs.com
 ([fe80::64c4:43fb:fd0e:14d]) by BYAPR01MB4438.prod.exchangelabs.com
 ([fe80::64c4:43fb:fd0e:14d%7]) with mapi id 15.20.5709.029; Wed, 19 Oct 2022
 14:58:57 +0000
Message-ID: <c99954a5-ab6f-c412-ae27-456495b57817@talpey.com>
Date:   Wed, 19 Oct 2022 10:58:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 1/3] nfsd: ignore requests to disable unsupported
 versions
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20221018114756.23679-1-jlayton@kernel.org>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20221018114756.23679-1-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To BYAPR01MB4438.prod.exchangelabs.com
 (2603:10b6:a03:98::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB4438:EE_|BYAPR01MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc5a064-0c29-4958-2bc6-08dab1e2729e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcWeD8eXDCc2muedEsMIkbaWhYXuEt3ChDDWezMS8w1hbx7AX6iOmtIHp0jx/IkFoDlpUO8XOG9ixgnZCfaS7e0h0ZaJS2Gx1V42oy5CA6+Iu1CWf80yEi01oJop+9gp1K0uNLjCXISSMWtNEyKSXcU0IngL6qyVuCyECxNpdQ6VvM2l+X2kVC5QpIK5XcayqrwcaRpBGBuFlAOHmQzftN8bFKCYcxFqxBRLMWlPfDEhZ6la7Lpk8s3CKvuryOVWK6XKtqLrl4C2i8Iq66/3q83OKpmBQK5vf0JKQAbd74/qkX9sa93YpErz+KLiEAKIXBv0+nKPwbDGH8yqp/xLahAnA4HZw0xxgrbS4N/9R3PG1py+HaYYYLDHuhWExYkLM/AOfrBAGnKM6IpHbcfim9ihIfyPqiqCyktCFAYkoXFkokIRCeKkHYxS/pEHa9dsDjcEtEBpZi12SG5mPz1qL88trcJGmEeRt6OYyed8hdTKf35p0+dC/MpnWTBmGtgZQjfSvsrhUElXOeSFBqz7cLtdR+FNw+3l9ntyevCiihUFpmfnJP14VFraFi4ThU9WliaUAxKrCmNysuwvpFziHjdbuEFjXzOwcmelY+CL5flYScBqBwuFudD9yybabzXXbYOl+8LmxcZbI7YFCAAd2bo0IDMDUAH2Wd5U1BM4fRLq0x562jdP/EEPZbczHEiPnia7hZsCIZs5FgeqEAZI6RSzHdZVFgFzWdTix/WX9DFMYFy77tbMfUnEWy4axvSCjJgFSde2aRkiIv/y5SLrAJU4WSnLJds5JUF5Pnbd+F4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4438.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39830400003)(396003)(346002)(376002)(451199015)(8676002)(5660300002)(2906002)(31686004)(4744005)(53546011)(66556008)(66946007)(316002)(41300700001)(36756003)(478600001)(6666004)(6506007)(8936002)(6486002)(4326008)(26005)(83380400001)(52116002)(38350700002)(66476007)(6512007)(38100700002)(2616005)(86362001)(31696002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FuV2kxRTc0dVArMmw4dWR4ODZQTTg3c3NiTXQ1V0dJeG5zR1hyUU14VjlM?=
 =?utf-8?B?QWllK1ZzM3FidVcvTjhyVWIxZDRaMUphNEJvL0NZNFJHUkVySkV0dmg5Mmpa?=
 =?utf-8?B?bENENk9Cd3YrVXdEaDFXQ3dyUXdRbUdlWWR2Z2dGQ2swZXNCdmVONTdoS1Iw?=
 =?utf-8?B?cnBOWVM1VW5Sbk83ZHA1a2FhbzhVUGQ3OUJOd1lvOVRqc2FQWldVMnpaSzE3?=
 =?utf-8?B?VmVWbDdlL2dGY2NkMWVnQ1ByMTk2dytEYTVRUk81dUEvTFhQRlVTSHlnSVRv?=
 =?utf-8?B?RDVKWEFzQWZlVmZJVUgzWVRZblVNaVJPNlNycHBFdjB6dHNKRndWc1pMczVD?=
 =?utf-8?B?Mnp5YVdlMnVmOVdXMWdKbzEvMmJVQ3N2RDZSWEtsMkdJeEo3UXVVeSt6Zitk?=
 =?utf-8?B?RWlFb1lhR3dtR2JhSE4xMmp3TTVqWGZTVTd0aVdWYzluR3NQRktXSzI0NUd3?=
 =?utf-8?B?cnB2WWFyWnVDekxxbWFsbktOVGFTMjdYV1Y0RmVBT3locmVnZmNHU3hNM2Nx?=
 =?utf-8?B?RmJIdzBUY3FuS1NyTHNlNTduUDJJQzhyM0Z1NEZ1U0tUTUh2M2FtS1F0VGlB?=
 =?utf-8?B?eVhYNDhqd0Nadmc2UFVBZkZvZW1kbEtONWJJMVd6R0xMQjI0THRmdCt4S3JQ?=
 =?utf-8?B?bFVaVEtvWmlINllFZmt1a0syMGZFM1RMYWFTY3kvcENEa01yaWRFeEZ6RzRJ?=
 =?utf-8?B?czgwWjhLV3VseENVQ2lKT0ROR1BNdExxUUU4L1IrY3U4VnpPY08yRWNxc2k3?=
 =?utf-8?B?dTdXZVBJc2cyczJuMHRwa2RHbFdZWjZ5WWVnQnk4NDJEYlVwWTI1WkhWQnBG?=
 =?utf-8?B?ckEzc2F1emZYOXhCYkoyUktmaXZuTi9FcHFkRVVyMWFPSUlmd1dObERIeUpK?=
 =?utf-8?B?clhJZGVJclVjWGtzaUFtTEZYUXpVdlR5M2xnRTBIdlNKNTNyL2YzZ210Qklm?=
 =?utf-8?B?VzlaUGpXRmdFczBlQUhhdHEwMWRGWXI1ZlQ2TnVWeWJBY0hGTmVsSGtqM1B6?=
 =?utf-8?B?a3FrcGszdDFYancrejVDVXFaOXFPTCtaSlArMExuN2F3NFJxR1JQb0gyTWp1?=
 =?utf-8?B?WFJ1VDRYcVREeGVzSmtoQWY0TFpJam15dnZSU3lCOGhZMVJZT2xsMTlMZkFC?=
 =?utf-8?B?dm0vcU40RjVSbE92bno0WDV3dHJxaXd1bVlVVEtJYUk5V0Q0UXNpVzRyU2R2?=
 =?utf-8?B?WkRlQytqN29MeGdLK09qSEtnMldvd3NlMmM0RTd0Ni92T1BoZ0Z0ejBGKzVv?=
 =?utf-8?B?WC8wOHUybHpNd0tQWmRvME03Vmt4ZVBZbWU2eVM0VUtJalN4UGIzbjNnSzBM?=
 =?utf-8?B?NnhkOFh2ZE8zUDA2eUVyRUdYSWlaOGR2dUdNSmxUM3ovdFJyTkVPUzIvYy9m?=
 =?utf-8?B?QmJYOEg4ZXlWUk82UEJpWEJtTTlzeXRUWEZTWDI0RG5DbGFxQXZMRys2R2o3?=
 =?utf-8?B?WXlvUGVCY2hzRExtVzFRZDMvZ0FTWTZFcGJTSWxaOC9FKzBKVzZnYTNkYXZW?=
 =?utf-8?B?Y25BNGZPeC9XZTlZZFF1ckNjeGdCeFhybWNHMGV3WTQ1dGczbGdEd2Z0MTk0?=
 =?utf-8?B?aDZSK2NLOGJaMkZWL3Q0c0RoTnZlcWVGNytHVDA3WG9zTm1EUjM5SzRmTmox?=
 =?utf-8?B?QitZRmNsYnZKTDBVc3orT2RmZ3ZwQnRvQmcvZTJSVXF0cWlQdlI5eHZENDJ3?=
 =?utf-8?B?YTF1dU9aT3QydHU2MFhDMEZGTzR5NWJBY2F4TlB2MUEwbnA5SVhDbzdWYzhD?=
 =?utf-8?B?dHc2bGNodFEyQXRXckQzd1BTZGZZUitHNG5UUTV1VTF5Rjd5MXlWR3lYOXdY?=
 =?utf-8?B?RW9PcThidnJ5emQ0UXVSajJjQm5tdHB3dExUMzF1RGNLclREbTF6UmxjWG1Y?=
 =?utf-8?B?bWlQcjRFaWdvYkNHbkVOeSs3akJMd2pOREdHcGdOWDFVaUZvZU9NSDhMVk5o?=
 =?utf-8?B?aFl4VHZlK2FaTXVKQ0lQY0IzNFBNSktvS3hCcTErMXJoTW9ldUVoMUk4dzJO?=
 =?utf-8?B?NC9sdy9TQUlLQVlHMVRrWkFXU0YvcUdzc3BPWTVES1ZMT3NQMjdjcEt6aEVZ?=
 =?utf-8?B?MklScitQeHI0eGMzb2l3cjUrZ3Izcm03Q01GTTNXRmJuZFo4SDhlanVMMm1T?=
 =?utf-8?Q?u0T0=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc5a064-0c29-4958-2bc6-08dab1e2729e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4438.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 14:58:57.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldXR4eCEqD6Axs4Bogi9UgIVZmaaydbHWk6EzdbHU0cmzaD66b+XDnJS+BpzdUJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4373
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Stylistically, I think this needs a "break;", but otherwise

Reviewed-by: Tom Talpey <tom@talpey.com>

On 10/18/2022 7:47 AM, Jeff Layton wrote:
> The kernel currently errors out if you attempt to enable or disable a
> version that it doesn't recognize. Change it to ignore attempts to
> disable an unrecognized version. If we don't support it, then there is
> no harm in doing so.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfsctl.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dc74a947a440..68ed42fd29fc 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -601,7 +601,9 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
>   				}
>   				break;
>   			default:
> -				return -EINVAL;
> +				/* Ignore requests to disable non-existent versions */
> +				if (cmd == NFSD_SET)
> +					return -EINVAL;
>   			}
>   			vers += len + 1;
>   		} while ((len = qword_get(&mesg, vers, size)) > 0);
