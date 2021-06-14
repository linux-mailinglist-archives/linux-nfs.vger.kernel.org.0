Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF853A70B9
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhFNUxA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 16:53:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55666 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhFNUxA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 16:53:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EKopoi047796;
        Mon, 14 Jun 2021 20:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=lTJbZ9uqgUJl7N+UczUMFQkrc7XNXpu9zYBm7PZxM68=;
 b=iaNM2FmAAhBGTCr5I5JmRKUcP0iuNLgDzjUlEiILqyEVh03dpgocbiV7qU+DlwHlzRqE
 nTU9jd17v3jBitpzYBKQ1gsfXrDnMpt44rZXvyOC+A6J/cPwib/mTTHpRzRltfN8dMZi
 YqEcyoPhs6Y9gEtUzrLnLneVdhmDBAHVT+2z1CxGQ/PFYYk38R+VphLmergSq3tN1Vhu
 0u4rTV9viYSO/K68nxO11jq0it9IGIzk4XJHEqEMOeTvPTYscl2E6dUrYBa3zw4T8cng
 e5GURRx7hEVw/5SfB35p29xZ2rtSa7Wl2/jz0QHS4sO1t4BhxOXlo7YKeF3ce6UoQDTB sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 394njnvgfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 20:50:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EKojYr160908;
        Mon, 14 Jun 2021 20:50:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 394j1tjt0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 20:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXZrj9XPRWqywGOblyPbrGlhgKi7nZ8eLC2NV/1DNqNN+AGPsEt6B+XMOgXZmATQ9Vu11gAUs+6pHlxASDvhtgzzmGp6HEm0MzGvbufhDzJnDK0ORAeWUI1DRgPn+4r5KlImOS9Qe7i6X51u8SlN+UUCxLXPzcuDci+Mc9X7NvBxpLnQhNwkpXbRF3Yg3mH9F1iLbeEzAEPHcQ4xqndCcALX7C2yRPaDDYaunRPJpcQkkcOHrl4uDqQPArrooJNRo/hNcvQ6UWU5NoGydS0vJxQrEimfbwpMiNTzDDnuuR9YtYDSTq/dRvx4wVTYHx6IbAmmOSufVvA87YWMEeZl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTJbZ9uqgUJl7N+UczUMFQkrc7XNXpu9zYBm7PZxM68=;
 b=Eg7H8P/kej0SX7Fu2Zx9a4XXFxx4fGygRyy+mUAJDQPoVm7nRHoQoW6AOTPa2U+uWjZ+MO4uC0JJbf7Yv6dUidAWsv/gys5wjYrA6Exingkit3WxsfD9GvDmt3GbRzisKGlGadhHnyMwsjFR/f3r+VQwnMnaYmtYWwAcqFT7bEKHy4jbovoPy5/I8uoWTdiD9yiTRTVCKvKyTsrTmwWln6Ps/qHMsnP3dhPcx4Q5JWVJPr4ho1a7hMTX/tmAICyZqzHwPaBgEuQLn3fztxqRyOKbFtedOeMQ1DPrE8ky4vDMCxcUT0qdcVpZW5W9d8ntSabdAQIGYeFwGgM7+tnrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTJbZ9uqgUJl7N+UczUMFQkrc7XNXpu9zYBm7PZxM68=;
 b=sAFeUW/tUujl94me683+WgDo4JPpcqDs5pAuH5O7KUJTNJpO4XQyLxQ9iv0Y+91hCsr7DhmabGjJkkRutFpW3mxr9iScXNx1joyj5cHt4Di8V6csPHsyxoZi7bdEY2gzaDIG+w2pzs9SLVmJx2PcY1n92lb/l6LZ8lJWEVb1mtU=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN6PR1001MB2132.namprd10.prod.outlook.com (2603:10b6:405:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Mon, 14 Jun
 2021 20:50:40 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e%7]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 20:50:40 +0000
Message-ID: <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
Date:   Mon, 14 Jun 2021 21:50:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0a1
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Content-Language: en-GB
To:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
In-Reply-To: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9v4F1iVMVAZcggocnGIvzJi4"
X-Originating-IP: [90.247.86.106]
X-ClientProxiedBy: LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::14) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.86.106) by LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 20:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504bf294-6406-4316-8afc-08d92f7611b2
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1001MB21328717043646B27EED116DE7319@BN6PR1001MB2132.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyi+T3Kh/PR7fpblWvCVkdSuq0MYCFV12Aj42oxxvhvvz1VkzCpjmV/FrM0RqRLDij3ZqFZDtqNyCyivMM75T0G9oTnhPvs9LjXhUq97/LnBxRs/7WHbJPYa8ONV/kCA973e+Z2A2QrkEJzRk3CjE068dJ0+ZbjiLtjRkdwHxzXqug6nj/2OHluptWIFcn5FyqxmBhVO/ebqY2QMSgQfxTRzzgP+hIKAX1C18csNGnjRw4kD2LREQZzPO+2eLKVvBzazYceNctjGa5PxSDGF2OS/1L8Zjsusd5o7oXKCW2xh5Ub9Pz2xpdKAJ1IFdfOnj6EApiKHcOa/vZymugcl3s//dXkhW6yTFXXhZ6ynhEV2LnO+FETeQFL3+NGh4n3YbwXYqeOCGhaP+7BQ9kR4yBi3AWsVt9nMn3JLL9bY7S1dGG+JPp0vOC8//MSTb3r+F9Ffhe/ZNOgBQ4Hl4lnm9uiBppCzpjq5tYNeMaPwJLm7N+hr2336coPo4aSadBO8wVSBAFSV+0JHY02TttFR6jp8OiANy7JpHG21afKDzMbagNmKriROTvjSNeQXtU+AeTI9ZZ9/NgzkXkX7ZSW038+bncS8qQkkapBXQ4PwtSkrtV7ctqb4M2IRhncktnHDhONEhPPxAf/+I0En8BLhyGxOvYJRU/x5NrMm1lrDaQmnM6Ev7bF938q+26cSbmd1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(66556008)(21480400003)(4326008)(16576012)(956004)(54906003)(316002)(36916002)(2616005)(45080400002)(5660300002)(83380400001)(33964004)(16526019)(2906002)(235185007)(86362001)(26005)(36756003)(66476007)(31686004)(44832011)(110136005)(6486002)(66946007)(8936002)(38100700002)(8676002)(31696002)(478600001)(6666004)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21KL0hkQzRNaXovdUdKTldzb2U3eTFXMzFvZ2xEbWg2ZlJVYTd3eko3d2lB?=
 =?utf-8?B?Smp6UzR4MXo0cVhLVFZSNFY5RlJSSVdOREFSUk0zVklMSktNbWZLSWYxMUtk?=
 =?utf-8?B?TXJWWmQyZElUcXl6TDV6eURPaG9kazdKamtSdzNkQi9Tay9tekhtMExlSTJF?=
 =?utf-8?B?TlhpT1ZKVmxDMTBDUjRxa2x5bDNCbCtNVjlGcmhYb25mU2h1K3ZDZVdEenRG?=
 =?utf-8?B?YkUxWlZMUzRNcDM1ZzN3Sjc4YVQvQmhudmdlM1lBYlVSMTBjb3RibHVjZXor?=
 =?utf-8?B?WGFjR1FnbHZmSVVVZjV3b2xOZGZ0b1g4U21zTVJGd3ZVMHFtS3gzemNzNG84?=
 =?utf-8?B?aEVaS2gxQ1JYaFYwY0tHbW5taEYzdVBIaUpnazliMWs1Y05yL1d2cmlNTnZI?=
 =?utf-8?B?c3VzeHNPV0I0SFRLb0syaGVPK1ZvY0JSREhCRkdubEhuNGlpNUZLRG5ONXhm?=
 =?utf-8?B?N2NOMDB3TEptTHVPMER5TkZvd21kaHEyd2FtYURNMWZmVDNINlF2RkRkQjNW?=
 =?utf-8?B?ZVd3VjQvb3AyVHNNVUdXbUcwN0k3Q2x5Y2gvTkpCZmlCY0NBNGYxa21WTVAz?=
 =?utf-8?B?Tzd1ellFWnU5NGJndVl6bExkdDUvZndPZmR6M3Mzb2hSWTlsU0QxS0hWY2kr?=
 =?utf-8?B?VGt3cmdvejVyeXBJd2VMbC8rNUhrZ01xNnZHOUtkZ01TRkhISlhMTU9ocUhP?=
 =?utf-8?B?VVNVQzM2RlVlVnVzMTJ4M3NyZ2orSHU1eldqbU1iYjZVM201ZmZpcnd4Nnlh?=
 =?utf-8?B?ajBNNm9vKzRQQ0VRcEh6QnBMMEZtRW04aXRzd2E3NmVUUlVNcDVCLzVjY1Nt?=
 =?utf-8?B?RWFaOUhYMSt3Uk1uT3lON1FDVERrNjFXZ0huUVRhTTU4TTFHSy9oaERVMWEx?=
 =?utf-8?B?bFF2SEZuWEp6cGdWekttL2pEZWd6WmJqZkFFMlUwQ2V6eWs0UDh4QThPNGNO?=
 =?utf-8?B?ZXMydTVGMThkeWZ5ZmtGb29jOE9sSS9id1VUN05qZTdqQmVhekNxbXdzM29K?=
 =?utf-8?B?dzZHN3ZYbGora2dqR28xT2VFbGxnMVoxS2c0RXNIWjFHRGdBbGVqakZiOW40?=
 =?utf-8?B?ZDRHbGg0bFBqazVJc2RnY29JMlNORjFPZFR0YmFMNWtDUXl3dmFJbHE5eXpR?=
 =?utf-8?B?NWdHWE9jU0hzSU1sREgxOUJVanI2VzRqdDJYd1YwRGFtbmYzYlZLeDBaVkZi?=
 =?utf-8?B?WUp3emZVZ2Q0b1BMdk5RRGxiOXpZVGY5WkJiZ1lyTFZxcTkzSk42d0xSNVVt?=
 =?utf-8?B?VzlKYThwa2crbnRVbVBvSmQ1SnhzRzFxcStWeDd2QUsyUDVxcmVlaENkYjRt?=
 =?utf-8?B?NGF4ZmJ6aDVtMFFSTU9aTVUrNjJ4T2tmamp3cTFFWW0yZWYxQW5qL05hK2ds?=
 =?utf-8?B?L3BsRVR6Wi9JM2t2WktEY0NacXRidmIyTlVYM1NyTlpKanBmSGRrU1VhcFZV?=
 =?utf-8?B?ZHJ6MytzTGFXWHRrdGFWMEFwd1I3R1FBK3AwVGlzY1dNSEZVMXp0YXA2SXBL?=
 =?utf-8?B?QVRES0xoUU9HVHVIbWYwa205QUJWNGMzamR3VjlvYTY3Tkw3cmtWYk9iQldQ?=
 =?utf-8?B?WlV6ZHdzWGhZbjFac1JwYWdCSDN1U0lORVpTclF0bXg5eklsYWdkUXhNN0FE?=
 =?utf-8?B?SDdaRkU1S25CeDNRdkFYZkRrODEvd3BqN24vbjRHYXNOOVdobWkzZ2o5bHBy?=
 =?utf-8?B?UmYxVHBRMFpyS0FvcFZ4cm10dFNWbG56ZzVwa3Q3MWtPam1RaWVWSFV1VUtX?=
 =?utf-8?Q?7mTMGp0EgudYOWemYp6goP3N5Cq5E0LN5lJu5xM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504bf294-6406-4316-8afc-08d92f7611b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 20:50:40.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: punmifT06K7DHlT7DBNOMgdnIyyK6hwdSTEXD2JIj/5Qgy+fXjSSkyKisK0Q/121mpEnq7QbV77wmr94O2uZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2132
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140131
X-Proofpoint-GUID: NJ5wI9Gb_5fqMMjrI8H5DQQ4HbPfSMm7
X-Proofpoint-ORIG-GUID: NJ5wI9Gb_5fqMMjrI8H5DQQ4HbPfSMm7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------9v4F1iVMVAZcggocnGIvzJi4
Content-Type: multipart/mixed; boundary="------------Y8SC22RGP25w2F2YiUqNKlbB";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 "bfields@redhat.com" <bfields@redhat.com>
Message-ID: <91f1d7df-b63c-4aa3-cc03-a8e1cbb2ecb1@oracle.com>
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>

--------------Y8SC22RGP25w2F2YiUqNKlbB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMDYvMjAyMSAyOjAxIGFtLCBzdXkuZm5zdEBmdWppdHN1LmNvbSB3cm90ZToNCj4g
VGhlIHRlc3QgZmFpbHMgb24gdjUuMTMtcmM1IGFuZCBvbGQga2VybmVscy4gQmVjYXVzZSB0
aGUgc2Vjb25kIHNlc3Npb24NCj4gZG9lc24ndCBzZW5kIFJFQ0xBSU1fQ09NUExFVEUgYmVm
b3JlIGF0dGVtcHRpbmcgdG8gZG8gYSBub24tcmVjbGFpbQ0KPiBvcGVuLiBTbyB0aGUgc2Vy
dmVyIHJldHVybnMgTkZTNEVSUl9HUkFDRSBpbnN0ZWFkIG9mIE5GUzRfT0suDQo+IA0KPiAg
ICAgICMgLi90ZXN0c2VydmVyLnB5ICR7c2VydmVyX0lQfTovbmZzcm9vdCAtLXJ1bmRlcHMg
Q09VUjINCj4gICAgICBJTkZPICAgOnJwYy5wb2xsOmdvdCBjb25uZWN0aW9uIGZyb20gKCcx
MjcuMC4wLjEnLCAzOTIwNiksIGFzc2lnbmVkIHRvDQo+ICAgICAgZmQ9NQ0KPiAgICAgIElO
Rk8gICA6cnBjLnRocmVhZDpDYWxsZWQgY29ubmVjdCgoJzE5My4xNjguMTQwLjIzOScsIDIw
NDkpKQ0KPiAgICAgIElORk8gICA6cnBjLnBvbGw6QWRkaW5nIDYgZ2VuZXJhdGVkIGJ5IGFu
b3RoZXIgdGhyZWFkDQo+ICAgICAgSU5GTyAgIDp0ZXN0LmVudjpDcmVhdGVkIGNsaWVudCB0
byAxOTMuMTY4LjE0MC4yMzksIDIwNDkNCj4gICAgICBJTkZPICAgOnRlc3QuZW52OkNhbGxl
ZCBkb19yZWFkZGlyKCkNCj4gICAgICBJTkZPICAgOnRlc3QuZW52OmRvX3JlYWRkaXIoKSA9
IFtlbnRyeTQoY29va2llPTUxMiwNCj4gICAgICBuYW1lPWInQ09VUjJfMTYyMzA1NTMxMycs
IGF0dHJzPXt9KV0NCj4gICAgICBmaWxlYidDT1VSMl8xNjIzMTE5NDQzJ2NyZWF0ZWQgYnkg
c2VzczENCj4gICAgICBJTkZPICAgOnRlc3QuZW52OlNsZWVwaW5nIGZvciAyMiBzZWNvbmRz
OiB0d2ljZSB0aGUgbGVhc2UgcGVyaW9kDQo+ICAgICAgSU5GTyAgIDp0ZXN0LmVudjpXb2tl
IHVwDQo+ICAgICAgc2Vzc2lvbiBjcmVhdGVkDQo+ICAgICAgKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gICAgICBDT1VSMiAgICBzdF9j
b3VydGVzeS50ZXN0TG9ja1NsZWVwTG9jayAgICAgICAgICAgICAgICAgICAgICAgICAgICA6
DQo+ICAgICAgRkFJTFVSRQ0KPiAgICAgICAgICAgICBPUF9PUEVOIHNob3VsZCByZXR1cm4g
TkZTNF9PSywgaW5zdGVhZCBnb3QNCj4gICAgICAgICAgICAgICAgICAgICAgIE5GUzRFUlJf
R1JBQ0UNCj4gICAgICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKg0KPiAgICAgIENvbW1hbmQgbGluZSBhc2tlZCBmb3IgMSBvZiAyNTUgdGVz
dHMNCj4gICAgICAgIE9mIHRob3NlOiAwIFNraXBwZWQsIDEgRmFpbGVkLCAwIFdhcm5lZCwg
MCBQYXNzZWQNCj4gDQo+IFJGQzU2NjEsIHBhZ2UgNTY3Og0KPiAiV2hlbmV2ZXIgYSBjbGll
bnQgZXN0YWJsaXNoZXMgYSBuZXcgY2xpZW50IElEIGFuZCBiZWZvcmUgaXQgZG9lcyB0aGUN
Cj4gZmlyc3Qgbm9uLXJlY2xhaW0gb3BlcmF0aW9uIHRoYXQgb2J0YWlucyBhIGxvY2ssIGl0
IE1VU1Qgc2VuZCBhDQo+IFJFQ0xBSU1fQ09NUExFVEUgd2l0aCByY2Ffb25lX2ZzIHNldCB0
byBGQUxTRSwgZXZlbiBpZiB0aGVyZSBhcmUgbm8NCj4gbG9ja3MgdG8gcmVjbGFpbS4gSWYg
bm9uLXJlY2xhaW0gbG9ja2luZyBvcGVyYXRpb25zIGFyZSBkb25lIGJlZm9yZQ0KPiB0aGUg
UkVDTEFJTV9DT01QTEVURSwgYW4gTkZTNEVSUl9HUkFDRSBlcnJvciB3aWxsIGJlIHJldHVy
bmVkLiINCj4gDQo+IFNlbmQgUkVDTEFJTV9DT01QTEVURSBiZWZvcmUgdGhlIGZpbGUgb3Bl
biB0byBsZXQgdGhlIHRlc3QgcGFzcy4NCj4gU2lnbmVkLW9mZi1ieTogU3UgWXVlIDxzdXku
Zm5zdEBjbi5mdWppdHN1LmNvbT4NCj4gLS0tDQo+ICAgbmZzNC4xL3NlcnZlcjQxdGVzdHMv
c3RfY291cnRlc3kucHkgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3Vy
dGVzeS5weSBiL25mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NvdXJ0ZXN5LnB5DQo+IGluZGV4
IGRkOTExYTM3NzcyZC4uMzQ3OGE5ZDkzZGJmIDEwMDY0NA0KPiAtLS0gYS9uZnM0LjEvc2Vy
dmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weQ0KPiArKysgYi9uZnM0LjEvc2VydmVyNDF0ZXN0
cy9zdF9jb3VydGVzeS5weQ0KPiBAQCAtNzQsNiArNzQsOSBAQCBkZWYgdGVzdExvY2tTbGVl
cExvY2sodCwgZW52KToNCj4gICAgICAgYzIgPSBlbnYuYzEubmV3X2NsaWVudChiIiVzXzIi
ICUgZW52LnRlc3RuYW1lKHQpKQ0KPiAgICAgICBzZXNzMiA9IGMyLmNyZWF0ZV9zZXNzaW9u
KCkNCj4gICANCj4gKyAgICByZXMgPSBzZXNzMi5jb21wb3VuZChbb3AucmVjbGFpbV9jb21w
bGV0ZShGQUxTRSldKQ0KPiArICAgIGNoZWNrKHJlcykNCj4gKw0KPiAgICAgICByZXMgPSBv
cGVuX2ZpbGUoc2VzczIsIGVudi50ZXN0bmFtZSh0KSwgYWNjZXNzPU9QRU40X1NIQVJFX0FD
Q0VTU19XUklURSkNCj4gICAgICAgY2hlY2socmVzKQ0KPiAgIA0KPiANCg0KSSdkIHN0aWxs
IGxpa2UgdG8gY2hlY2sgd2hldGhlciB0aGlzIGlzIHRoZSByaWdodCBwbGFjZSB0byBmaXgg
dGhpcy4NCg0KSW5pdGlhbGx5LCBJIHdhcyBjb25mdXNlZCBhcyB0byB3aHkgdGhlIGZpcnN0
IGNsaWVudCAiYzEiIGRvZXNuJ3QgZmFjZSANCnRoZSBzYW1lIGlzc3VlLiBBIG5ldHdvcmsg
dHJhY2Ugc2hvd3MgdGhhdCBhIFJFQ0xBSU1fQ09NUExFVEUgaXMgaW5kZWVkIA0Kc2VudCBm
b3IgYzEsIGRlc3BpdGUgbm90IGFwcGVhcmluZyBleHBsaWNpdGx5IGluIHRlc3RMb2NrU2xl
ZXBMb2NrKCkuIA0KV2hlcmVhcyBvbmUgaXNuJ3Qgc2VudCBmb3IgYzIsIGhlbmNlIHRoZSBw
cm9ibGVtLg0KDQpUaGlzIGlzIHByb2JhYmx5IGJlY2F1c2UgYzEgaXMgaW5pdGlhbGlzZWQg
d2l0aDoNCg0KICAgNjEgICAgIHNlc3MxID0gZW52LmMxLm5ld19jbGllbnRfc2Vzc2lvbihl
bnYudGVzdG5hbWUodCkpDQoNCg0KYW5kIGMyIHdpdGg6DQoNCiAgIDc0ICAgICBjMiA9IGVu
di5jMS5uZXdfY2xpZW50KGIiJXNfMiIgJSBlbnYudGVzdG5hbWUodCkpDQogICA3NSAgICAg
c2VzczIgPSBjMi5jcmVhdGVfc2Vzc2lvbigpDQoNCg0KVGhlIGMxIGNhc2UgcmVzdWx0cyBp
biBhIFJFQ0xBSU1fQ09NUExFVEUsIGJ1dCB0aGUgYzIgY2FzZSBkb2VzIG5vdC4NCg0KSSdt
IG5vdCB5ZXQgc3VyZSB3aGV0aGVyIHRoYXQgb3VnaHQgdG8gYmUgZG9uZSBpbiANCm5ld19j
bGllbnQoKS9jcmVhdGVfc2Vzc2lvbigpLiBJZiBzbywgdGhlbiB0aGVyZSB3b3VsZCBiZSBu
byBuZWVkIHRvIGFkZCANCml0IGV4cGxpY2l0bHkgaGVyZS4NCg0KDQpbSSBzdXNwZWN0IHRo
aXMgd2FzIG1pc3NlZCBpbiBteSB0ZXN0aW5nLCBzaW5jZSB0aGUgU29sYXJpcyBzZXJ2ZXIg
SSANCnVzZWQgbWF5IGJlIGxlc3Mgc3RyaWN0IGFib3V0IHJlcXVpcmluZyB0aGUgUkVDTEFJ
TV9DT01QTEVURV0NCg0KDQpJJ2xsIGxvb2sgaW50byB0aGlzIG1vcmUgYW5kIHJlcG9ydCBh
c2FwLg0KDQp0aGFua3MgYWdhaW4sDQpjYWx1bS4NCg==

--------------Y8SC22RGP25w2F2YiUqNKlbB--

--------------9v4F1iVMVAZcggocnGIvzJi4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDHwRoFAwAAAAAACgkQhSPvAG3BU+I8
WQ/6AiByVUaO3sd9ybNsMl+eRv8N3jVAgB7uTrQ4Qgcnoot8chbmIBRqZg2OehmuSuM/jedHEhnK
rW8BeV3vYgmTeEoTYpETOZZ7H/PEnkl+u/jFeWtUHNqkanTE+QkVQQffJFRStVeYZBNGjUETpNF/
kWpZX2IrLsWTBi7BYqkl2Y65wrGGTjeO6M8brmXBKFHvpODAER+/WwjWao7dPJtknixmOheBAb5Q
KglZBIPDwVZs0bAOfY5cIht3POtJNk3embRsVxko2HlqUP0dLnP36mHxbwRaVQS5d3PKGWDpt3Q8
1q7y0fozWJRlS6N0S6uCGblkyw49sQwv+rg70Gft6NRoJaJQ00pv28YWRkcLxZNsOnCWTqYXCI+c
kOmUC6Ont5MKcSZcXMtMLY0PjU4b2Xr9JxiRV3hllVTzL1iTgQJ/JzvLUI1Q0HJLeh5l1ozmqOn/
+2DMfYVUi8wBYm+x+MYV3TOdoh0EhgD02fDSwJwvH2VjCXvelo1wRwd3gB9SIZeigV9M14+Fsqmz
jTHM468VvkIMD0c01sa7gW2picXtKZsYUvVEGNgRaibZIMoZv4gm5SWIryXHSIDA0uzpLpTgba4d
5NLM7YEDzDrwrMqp/1QM3t8DZSZE34tT1C+P/tjrZCVM+O4DfS5oM6nugWhVGzbtluACTLTPDNcq
tf8=
=Zbgp
-----END PGP SIGNATURE-----

--------------9v4F1iVMVAZcggocnGIvzJi4--
