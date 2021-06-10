Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614FA3A2A8A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJLq0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 07:46:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLq0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 07:46:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ABiPpu114353;
        Thu, 10 Jun 2021 11:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : to : references : from : subject : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=0uQ7IYfk5JwLL0LGXg6UC7A3fXQPxwKal7Oz7WdpAyI=;
 b=gYt50e7fDBle/qJV9eKaUy7JdxTG2IxAPzQqooo5zCGYHP1VF7yR0GoAXq//qeQq2omO
 KErSnXLqVGFVrxH0s3muCsuPtYAvQFy4EgGEWlP02QascZ6VD6q6Hexru8z1uXcI83AV
 PrQ11vYQVag4a5Jq/56rh1MNu6TPPcTj92tJAcwu/jkgh3MHNN0hPQHMxlJvqBDGgfa5
 GRlSki3JWqeOnwGST3F5gZKT5UC50YbewhQUI1JfLP8JX1GVF57i3XS1aKxXLQzXRnCT
 qa7x76lA1MvQgjcMwpVLYmzfj1IPPl1bteZ+7Lgequ5YfWMmfH9bI3m579lyMJDEUFr4 Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3914qut9aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 11:44:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ABexHs007222;
        Thu, 10 Jun 2021 11:44:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 38yyacj7we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 11:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5TcchF+6Rdlaw1hSKurIoAXVpOsvdCcvI512+HjNaXYlz5OC7SpyeQTdUh2vjN0Ge2hKe3TFSJPhdGP8EBHgIseyTPMhH9XH5qCOfXk29VJ7b9U0azu1E8tUjEfqbL1nFviG8fgislqlb3pa90G0jJJm7B8cthG6lw/Flc8I5aS4zM6HeDX0xjLX3rAWxyvtjbrBvjv08O7htic2DYYZeKk6pfqel+aDmYnIkLwwW5vNlBRZ76LERaZ1gVQTPyNHbxp+Le4yG8IuiuUZSCe/xlRPP56LsRE/ydKAMRi/+dbpP4pTr7WZYlkcO0SNzgDNyRws7fKo0GoFijiyO5uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uQ7IYfk5JwLL0LGXg6UC7A3fXQPxwKal7Oz7WdpAyI=;
 b=hxBbgqo0d2sNmXwgJ0GAoaTREa93MosTCi2qSTdjsdOqzam6F8D8zduA9vppjmUszBErA7Af3iBRC8zPN2bBE06e/oYDiR0toBI7KZmGKZN2lWo93PL/zbSrWO42lo2DT4/j+uky0MmD/JnaavbmjzTqTE+8nJ+c5XbsivZ54puz/keIACU3N1K2zGkC0F36luIB39foF0Fy5uIqXGMLSnLwaVieHNwypt0DoBuYK6fC009n3KDmo8kgaEllJ+53vOF+YIOHT2MjeD2NLmnh1YHYbU9a1BYIr6vWbANItRWueIcN0HdehhAqpsguzgigiYM+0MbuFf5PPnto/cWzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uQ7IYfk5JwLL0LGXg6UC7A3fXQPxwKal7Oz7WdpAyI=;
 b=OQgermrmCHfg6JuESrEfpTm+4mAb7Ab615V8ZKSvWUajP5Jjro3FXOVl9FTIbLJRiTAH3LMddHfErZPq+V21mU0jigsGY5i805ZFFCE8xNDtTXbXLSG4aemYH1zn6kzc7Ua6qqd5ZYO5b4jXylj3nfeU/5U31hTjZiuyfzrl4wA=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by BN6PR10MB1794.namprd10.prod.outlook.com (2603:10b6:404:fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 11:44:22 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::286d:4172:d716:712e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 11:44:22 +0000
Message-ID: <110ffc13-6bc4-5f5b-d013-d29e9e4acc68@oracle.com>
Date:   Thu, 10 Jun 2021 12:44:17 +0100
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
 boundary="5gZfBVvhVq4MPWlMjdELT0W5qhIinVfOw"
X-Originating-IP: [90.247.86.106]
X-ClientProxiedBy: LO4P123CA0475.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::12) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.15] (90.247.86.106) by LO4P123CA0475.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend Transport; Thu, 10 Jun 2021 11:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a727a521-1d03-49f9-2d86-08d92c051708
X-MS-TrafficTypeDiagnostic: BN6PR10MB1794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB17941A120D5890C5811B2D1DE7359@BN6PR10MB1794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HL3ujleR7tArSOelW0LsIp56P7F0BsFOBSAAb9NqQmrqOu9aQCZ1cNf0HLAEQvWWarzEdLWYtxo7Lsp/QKgqS59k4u455eYpVO1q9XNrKPfDvyZwR+lsoScWqJMciJfI4BFRteDTrP9ul67YSAFdgXRIyJ7xVO7jHU4210kfCoIglFiobUVWTwlZj9kZOPbNrY7ArDVnQH0pNPrdP88Pcu8juKuPafooRkGiMzuI56Mwv03eQ8Cf3ZinWKS4M1MZWjk/qj1kfgk/++HbH/WPzQk/y/Kkt/juNhr0SZm7iFUiH1UySkIil73eq0KvWvLPxy6it3QlWe9eg126ShVBq88Q8rFsYaxc6NXtDpCCdRfn/4fQd3PhUJRC21AL8KwQEM7CF5A3s2ZSZdcBQWe7i4PfI/DJdHZzMTF5doTinimYWI5MNq1Oo0shjXyHRFx7eAh9KaRpWHh8y/Eq97puAWIUr1mz+1k5jGVZpymapWL4jgxlsb8/OYYtEasH5mUTupn43NKuP/L3TvfEWQoxrZcHdkWDUCM100g978uBm0pdNZYZDfkyS/dy42WwbJ4XL/lNaj3cwIG/fmjxFaqA57TMGCSXO1oPgYTzxUYZHU8dBLF2t27X58Z7kzPOY1IaFP3GO10R7pQhlNqLVDBFY/y+ioDMEygiUnWI3Fz57KnPt2GiNRFmT+WwT4B6S44T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(8936002)(8676002)(38100700002)(478600001)(6666004)(6486002)(2906002)(66476007)(36756003)(66556008)(44832011)(5660300002)(4326008)(956004)(2616005)(26005)(36916002)(53546011)(33964004)(86362001)(21480400003)(31686004)(16576012)(316002)(110136005)(54906003)(31696002)(83380400001)(186003)(45080400002)(16526019)(66946007)(235185007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE45ZTlHb29aQURaSWcwQXcvRFhHT1E4eGI5S0JOVWtPQWZzSkZ2VkJVRmVa?=
 =?utf-8?B?c3YzNmlCQW05R3N6anRNN1NZaFM2NWYveEVSUkxpYWFHSm9GZjZxalAraVlj?=
 =?utf-8?B?TTNuWjg2eXVnQjFtVXFTOU9VMS9JZWdCR2k0MkhNejBPSFpVOWF3U2lMU3pK?=
 =?utf-8?B?M1k5YVowRGRqMmE0OWZ5b2FBTHJ0Q1Z6eUkxV3dNaWowekthcjJhUDJYYkZM?=
 =?utf-8?B?VXZxUWxSUW4xUGVSdFRKcVREZXcvaG5WeUVEdTNEMFBLejUyUTFSM04vZ0hD?=
 =?utf-8?B?UWdDTHNDdmwrUHFVS3FEWE1NemtCdmpzZ0VrWVhURTRyQWZlMFFVLzdtOUl0?=
 =?utf-8?B?NW9Ec3VQV212di9oOWVNUVZkaTlZQ0s1aENYTFFJTHUwVFpZMVN5RGtabmVs?=
 =?utf-8?B?VGlZYlkrVUtGL2Z1cUs2MXFOUC9hbzg3YjBrV2xOVkh5cUZOeHpOWXN0cU1P?=
 =?utf-8?B?cUhTNitYMkFJSGRybmdlbnBIa3JQZXdBNHFaSGEvWmwwMVR5ay9qMk1NcTdy?=
 =?utf-8?B?bG81TWl6a2Q5dzZvaVZQVlAvY3h4c3gzMDlvSmxMdmVLZmJKNXhKRVFPSDM4?=
 =?utf-8?B?MmE3MDh3MjZzVUJWUGRBdDNrU0NmREhJNFNobktZbFloQzBEdmMzeGpoVTVP?=
 =?utf-8?B?TEdWc2ErNEVWdzdhM0REYmUrMFFENGdvTytETno2VVdFNklNUnpETk04T2tE?=
 =?utf-8?B?V3V4MDhFeTdRWTVxOUVHcWhyeXdjVkVsb1B2SWJTbForeWppd0VKTTJNSTNK?=
 =?utf-8?B?ZHo3U0RRRXp1NVQ3S1IrRzlaQlNpMkV5TE1EcFRXbjVSRW9KTGJoaktNUTVS?=
 =?utf-8?B?TVEwd3M1d0s5dDRqaUkybjYzQnVNcXFYQitFQWVmZHlIZ1I5Z1ByS2lBS1lV?=
 =?utf-8?B?SURzV0FNQVFJVm9TZ2lxWUlUbE9yVmVMZERGeVdpa09OTkJpSmpOeUNKNUI4?=
 =?utf-8?B?T2JWTGZIUDV0V2lvY0lCV1dVU1NmWUlxUXNYYnphNGU2Y3RDZXltcDZjNzFO?=
 =?utf-8?B?ZEhZbUxBQ2pyb1lqNTNUOU13anFVUlNCaVZWU2tNOStvb0RjYldFSEFkemxU?=
 =?utf-8?B?VDUwV3VVRG9QQThVeFgrTVNWU1FsUlZJZGNPM0ZWOVFmNkNBKzIzdk53NFJE?=
 =?utf-8?B?b1QyQkQ5R0U2V3Q1OFRQTGY1c0RzV3IwaU1wMzYyOVR0RTlaRHVUeXU0UjY3?=
 =?utf-8?B?c0ZsbzV6NTExRG1ySEF3Y2UzVDhyZzJmRHVYSXVGWER1L1I0NlZUcVNnbzlt?=
 =?utf-8?B?NTRyb3kxVjM5eXJsQXdvNzVaYWxhQTc3MkErcmMyM0l3VkswNmV5QU1POTJr?=
 =?utf-8?B?Y1I1TjZxNXRTNlZSblovcTQyOXhwcjJqT0xjanprK1hmRFd1YWpqWFc4VVkr?=
 =?utf-8?B?RmZlOWJHQUtOTE0zOWRTR0hiZUNuQVY1aXdGRVZSQkJPa2U0anAvOFVYVXVw?=
 =?utf-8?B?ZUZOTXQ3TkRtbGxEY2wzSnBwVkk5Qmcwa255NHhyKzlEVU50RVpWb240a3BI?=
 =?utf-8?B?blA2akVmOXJzYXRyR1ZzRjhDcTFTbUVhNmh6ZnAyZGd6NWFWRWQ2ME45dXJH?=
 =?utf-8?B?Y2hCWC8rLzhDcFlsK1VYcnJKdVZ4azA5aURhOTVSZVowaW1rQlNhV0E0dVFa?=
 =?utf-8?B?bHJCY3dZb0xmVFVKNHFjeUV1YkpNdXdZMG5DbHp5Ti9YMXp6dS85UllDa1Np?=
 =?utf-8?B?VERXZmppMTBmbktZSEpQMEVWaGFkNHQ4S1dyeXJWb0tKVmpKVWZacmtSc0l5?=
 =?utf-8?Q?spUiutFKKqmi6DqtZBawY7TrERg/beD4JHw/oju?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a727a521-1d03-49f9-2d86-08d92c051708
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 11:44:22.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW4/wtN18u8lHaj7NnJSTG3mwHvvAEwzIaKvVM8ou8B50Rbq2tpxTsINwAPUYFf/miDaNXn0sYjbsGw7Luzw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100076
X-Proofpoint-ORIG-GUID: D-HwDtVydhcmVI2SEBczFwZnUWwpr28A
X-Proofpoint-GUID: D-HwDtVydhcmVI2SEBczFwZnUWwpr28A
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100076
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--5gZfBVvhVq4MPWlMjdELT0W5qhIinVfOw
Content-Type: multipart/mixed; boundary="2Vc5Bc8xuzmfuEC6uMIOh7zjLf0tuvp8U";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 "bfields@redhat.com" <bfields@redhat.com>
Message-ID: <110ffc13-6bc4-5f5b-d013-d29e9e4acc68@oracle.com>
Subject: Re: [PATCH] pynfs: courtesy: send RECLAIM_COMPLETE before session2
 opening the file
References: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB2124D8FDDDCA29F5691F3DD089359@TY2PR01MB2124.jpnprd01.prod.outlook.com>

--2Vc5Bc8xuzmfuEC6uMIOh7zjLf0tuvp8U
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMDYvMjAyMSAyOjAxIGFtLCBzdXkuZm5zdEBmdWppdHN1LmNvbSB3cm90ZToNCj4g
VGhlIHRlc3QgZmFpbHMgb24gdjUuMTMtcmM1IGFuZCBvbGQga2VybmVscy4gQmVjYXVzZSB0
aGUgc2Vjb25kIHNlc3Npb24NCj4gZG9lc24ndCBzZW5kIFJFQ0xBSU1fQ09NUExFVEUgYmVm
b3JlIGF0dGVtcHRpbmcgdG8gZG8gYSBub24tcmVjbGFpbQ0KPiBvcGVuLiBTbyB0aGUgc2Vy
dmVyIHJldHVybnMgTkZTNEVSUl9HUkFDRSBpbnN0ZWFkIG9mIE5GUzRfT0suDQoNClRoYW5r
cy4NCg0KSSBzdXBwb3NlIHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB3ZSdyZSB0cnlpbmcg
dG8gcHJldGVuZCB0aGlzIGlzIHR3byANCnNlcGFyYXRlIGNsaWVudHMsIGJ1dCB0aGUgc2Vy
dmVyIHNlZXMgaXQgYXMgYSBzaW5nbGUgY2xpZW50IGdldHRpbmcgYSANCm5ldyBjbGllbnQg
aWQ/DQoNCnRoYW5rcywNCmNhbHVtLg0KDQo+IA0KPiAgICAgICMgLi90ZXN0c2VydmVyLnB5
ICR7c2VydmVyX0lQfTovbmZzcm9vdCAtLXJ1bmRlcHMgQ09VUjINCj4gICAgICBJTkZPICAg
OnJwYy5wb2xsOmdvdCBjb25uZWN0aW9uIGZyb20gKCcxMjcuMC4wLjEnLCAzOTIwNiksIGFz
c2lnbmVkIHRvDQo+ICAgICAgZmQ9NQ0KPiAgICAgIElORk8gICA6cnBjLnRocmVhZDpDYWxs
ZWQgY29ubmVjdCgoJzE5My4xNjguMTQwLjIzOScsIDIwNDkpKQ0KPiAgICAgIElORk8gICA6
cnBjLnBvbGw6QWRkaW5nIDYgZ2VuZXJhdGVkIGJ5IGFub3RoZXIgdGhyZWFkDQo+ICAgICAg
SU5GTyAgIDp0ZXN0LmVudjpDcmVhdGVkIGNsaWVudCB0byAxOTMuMTY4LjE0MC4yMzksIDIw
NDkNCj4gICAgICBJTkZPICAgOnRlc3QuZW52OkNhbGxlZCBkb19yZWFkZGlyKCkNCj4gICAg
ICBJTkZPICAgOnRlc3QuZW52OmRvX3JlYWRkaXIoKSA9IFtlbnRyeTQoY29va2llPTUxMiwN
Cj4gICAgICBuYW1lPWInQ09VUjJfMTYyMzA1NTMxMycsIGF0dHJzPXt9KV0NCj4gICAgICBm
aWxlYidDT1VSMl8xNjIzMTE5NDQzJ2NyZWF0ZWQgYnkgc2VzczENCj4gICAgICBJTkZPICAg
OnRlc3QuZW52OlNsZWVwaW5nIGZvciAyMiBzZWNvbmRzOiB0d2ljZSB0aGUgbGVhc2UgcGVy
aW9kDQo+ICAgICAgSU5GTyAgIDp0ZXN0LmVudjpXb2tlIHVwDQo+ICAgICAgc2Vzc2lvbiBj
cmVhdGVkDQo+ICAgICAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioNCj4gICAgICBDT1VSMiAgICBzdF9jb3VydGVzeS50ZXN0TG9ja1NsZWVw
TG9jayAgICAgICAgICAgICAgICAgICAgICAgICAgICA6DQo+ICAgICAgRkFJTFVSRQ0KPiAg
ICAgICAgICAgICBPUF9PUEVOIHNob3VsZCByZXR1cm4gTkZTNF9PSywgaW5zdGVhZCBnb3QN
Cj4gICAgICAgICAgICAgICAgICAgICAgIE5GUzRFUlJfR1JBQ0UNCj4gICAgICAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiAgICAgIENv
bW1hbmQgbGluZSBhc2tlZCBmb3IgMSBvZiAyNTUgdGVzdHMNCj4gICAgICAgIE9mIHRob3Nl
OiAwIFNraXBwZWQsIDEgRmFpbGVkLCAwIFdhcm5lZCwgMCBQYXNzZWQNCj4gDQo+IFJGQzU2
NjEsIHBhZ2UgNTY3Og0KPiAiV2hlbmV2ZXIgYSBjbGllbnQgZXN0YWJsaXNoZXMgYSBuZXcg
Y2xpZW50IElEIGFuZCBiZWZvcmUgaXQgZG9lcyB0aGUNCj4gZmlyc3Qgbm9uLXJlY2xhaW0g
b3BlcmF0aW9uIHRoYXQgb2J0YWlucyBhIGxvY2ssIGl0IE1VU1Qgc2VuZCBhDQo+IFJFQ0xB
SU1fQ09NUExFVEUgd2l0aCByY2Ffb25lX2ZzIHNldCB0byBGQUxTRSwgZXZlbiBpZiB0aGVy
ZSBhcmUgbm8NCj4gbG9ja3MgdG8gcmVjbGFpbS4gSWYgbm9uLXJlY2xhaW0gbG9ja2luZyBv
cGVyYXRpb25zIGFyZSBkb25lIGJlZm9yZQ0KPiB0aGUgUkVDTEFJTV9DT01QTEVURSwgYW4g
TkZTNEVSUl9HUkFDRSBlcnJvciB3aWxsIGJlIHJldHVybmVkLiINCj4gDQo+IFNlbmQgUkVD
TEFJTV9DT01QTEVURSBiZWZvcmUgdGhlIGZpbGUgb3BlbiB0byBsZXQgdGhlIHRlc3QgcGFz
cy4NCj4gU2lnbmVkLW9mZi1ieTogU3UgWXVlIDxzdXkuZm5zdEBjbi5mdWppdHN1LmNvbT4N
Cj4gLS0tDQo+ICAgbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY291cnRlc3kucHkgfCAzICsr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weSBiL25mczQuMS9zZXJ2
ZXI0MXRlc3RzL3N0X2NvdXJ0ZXN5LnB5DQo+IGluZGV4IGRkOTExYTM3NzcyZC4uMzQ3OGE5
ZDkzZGJmIDEwMDY0NA0KPiAtLS0gYS9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVz
eS5weQ0KPiArKysgYi9uZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jb3VydGVzeS5weQ0KPiBA
QCAtNzQsNiArNzQsOSBAQCBkZWYgdGVzdExvY2tTbGVlcExvY2sodCwgZW52KToNCj4gICAg
ICAgYzIgPSBlbnYuYzEubmV3X2NsaWVudChiIiVzXzIiICUgZW52LnRlc3RuYW1lKHQpKQ0K
PiAgICAgICBzZXNzMiA9IGMyLmNyZWF0ZV9zZXNzaW9uKCkNCj4gICANCj4gKyAgICByZXMg
PSBzZXNzMi5jb21wb3VuZChbb3AucmVjbGFpbV9jb21wbGV0ZShGQUxTRSldKQ0KPiArICAg
IGNoZWNrKHJlcykNCj4gKw0KPiAgICAgICByZXMgPSBvcGVuX2ZpbGUoc2VzczIsIGVudi50
ZXN0bmFtZSh0KSwgYWNjZXNzPU9QRU40X1NIQVJFX0FDQ0VTU19XUklURSkNCj4gICAgICAg
Y2hlY2socmVzKQ0KPiAgIA0KPiANCg==

--2Vc5Bc8xuzmfuEC6uMIOh7zjLf0tuvp8U--

--5gZfBVvhVq4MPWlMjdELT0W5qhIinVfOw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmDB+xEFAwAAAAAACgkQhSPvAG3BU+Lt
8A//XFCzoSV4zs6sQXRJADp86FfpdFpBg9A9yrhSrGa/CJmUCOSzKxcWvekCVMojlr9+a2V2s6Bq
TtGvSP9sEICdS6HB6ejAOuhZQ54/SlBpayaVawTgF5xdtQJtCgk5TyOM708+YJkvlnNpVfRALrs8
axL1Wdo/BDnJSQRKvhm3ULSiPiMEVJqQ7ASFUpl4LoFMhbd/Yk6elcz14ckkAyDYBKD6X/tjHfM7
yfx6Lnk8CLTSJvq06xpuQJLxva7eMJbKN0xJCt3pRx1GvpY/NiSPEMrA5PKlGJGio7ZLdxUaPtn3
80wfS+8NYbemdV6Z0Rnqnq2HwUR6TFP800izWHwstCDJvotygCsovQBw0dKc8L+DTNuk3/E7BRKc
bELtmPdpE0yAjrts9KbGFs7E8FM4ryHzzxaz6hpywCpEiXamLuFvBPH7aLUl11Am/kZ3pPnmPDp6
Un2lU+P6kIO7sA4xmkCxlrSsUcgTlovzvx2NrXHGgzJIZz0GJIyOT1GEEvo2iWV373rwxwHM/A/m
FHzM6lQ+iZ4RoJeY1WPVSvmCVk3xcR2nnQyQXL6FNp/UIxYso2kwk1FgbqZhm6LmAI3UPPmLVksc
xR/T5ttbrQNl165CAxq4SgKiyYJ5wUNs3ZojDnnGrec2Hp1/gQqdg59KJHrlE8l75H3tidCsWQPG
P10=
=VttI
-----END PGP SIGNATURE-----

--5gZfBVvhVq4MPWlMjdELT0W5qhIinVfOw--
