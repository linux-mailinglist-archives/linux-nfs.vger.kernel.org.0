Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF496F4A97
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 21:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEBTu1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBTu0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 15:50:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867A1BE5;
        Tue,  2 May 2023 12:50:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342INdFo029064;
        Tue, 2 May 2023 19:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DyDrbXvPWi2QyUstHOwOz8c39Mc47bplw0VuhinTsF4=;
 b=CaRDuMu6JjuN2wXm2XflcBDGqcjVpT3YsfXgDMM17eXM8cxJhcuJrEGcA2FlwDsQzvPz
 j7rJ9HRihme7Y37OyGBdrA3N1Ljq4goWbYM4U+9AogTlXsKqgLFCuMPPSSWgzG6eR3ho
 vjU/tC+ywoQ3MkQGMZgRMz1lPwVL3neZ6ETES7Q2fNkBBtuFlKLqjnAIDK9teR6ZMIiI
 9/4PBXdMRmpkzjypmYrA8kmFJRCfYCnjrLavnj0e+It7Lnsd/DiFeGk24AMXNpJqqweX
 NdxRUavXGwf9xnhx5ZfgMPxo9KjLmTGwxlhqsDRQVTOqB/5PhAsFLwVmyXDvwH3+lZIH QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9cwr3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 19:50:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342J5R9X027445;
        Tue, 2 May 2023 19:50:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spcftkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 19:50:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9Vxw5mFCN9xqffpiX8vnwTwEJMisg+IXSGqAeq2bkToqdWMj40m7+vC2Gomlm+fGfl81x4R2e2Bus3KuFoHGIw4zv6hmy2wuC+M+OQqFGKa9bHQA4ufeKf9pvYNxe+CaLL7zwT7UfYD3G+Ck/4DCOMV5qsrUcSyST0FUFrOfFpyHhDLmbuOXJwsg8ardkKkYw1gYbeHl3FtJZ04sPNqv2JWkVagYYbIlwcljeZZF+jS+SxVrsmnt/EZ2ZpqcL+N8Yfeaf5910MyS60P35MV6fZ3YjTjpY3Zs6NeQDxKSGmr4Ly6w7n6qIfC4SR+XuxD/sPOLMwoHy+dTjM43vG1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyDrbXvPWi2QyUstHOwOz8c39Mc47bplw0VuhinTsF4=;
 b=mF+HcE6tcRywOFrG0vuCIUCh/dvaEbD3u+LhKWaZGv31VUGtbM1804jlbYUzH0vA8cTeiJhCRO6LXRCrdHD+zcET76pCQuJptzVWSmHVGPo17SkprVrN/kKdY86ULvidKEeJ/9/V1lw/4AT7/w8WhHZntpJ5AEQAPxFAXSK4R9CFD8UcokCHYkU6tz5mp4fc1+T1VBgy0G5HRXJUx0wvOq3e+Wxj9cBNU5ZF+WwgHpQ5WAbuUcpGFm5rJ6WOcpF4x3oz8Ujyk3oMcDfH2Twk5GZwG6Qt3bQ49DiKqfP6QIG/g3hVG20U2Q8anSVwHAvmjWs5NCUDcMx+dE2ANN0onA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyDrbXvPWi2QyUstHOwOz8c39Mc47bplw0VuhinTsF4=;
 b=ttrfEJrA9wr5fpF+mMJ/jvgeef3cfMwwnT+h37R6vVh9VHQwR5zVFwx63sctI9pbq6fAViYBVzYiIFwgUyqSG/Uyf7QhLqV8Umh1b0MdOaoFQ5zIE5UFb2xvv2mz9Qo586efwy3EcPI9pZdjUz/8AJg1asOKlTpubx6OP5Ki1X8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 19:50:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 19:50:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Rix <trix@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockd: define nlm_port_min,max with CONFIG_SYSCTL
Thread-Topic: [PATCH] lockd: define nlm_port_min,max with CONFIG_SYSCTL
Thread-Index: AQHZfSDyBNMsXSHAbUWn0ZRVU0rFOa9HSkUAgAAaCYA=
Date:   Tue, 2 May 2023 19:50:12 +0000
Message-ID: <B683497A-DDCE-4CEC-A514-3114770CA6B7@oracle.com>
References: <20230502180713.2930022-1-trix@redhat.com>
 <f1b5a29c393e2f6b23420bfc94beceff1be69ae7.camel@kernel.org>
In-Reply-To: <f1b5a29c393e2f6b23420bfc94beceff1be69ae7.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6171:EE_
x-ms-office365-filtering-correlation-id: 7e3530dc-eaae-4ba1-0773-08db4b467154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iT0SKAeoNN4XtTlIhzct5wnYM0O7KpRD+uWC0NEe2UmMdIu8J8JdGPkFq5gfFij++rXv++TjiCeM7NKJidfgF7TFGTq8bYcVa5aSuYB5AgZiriljZujlb1rfG960B/j3V52w/drsf52XQKsM5N3W6eg7hg4582Q/jxew+ntgpaZIpxp01K8wvqob3V0X0KspEBm3lUL3+zk21TWKvw6t/ZNi9/WwGIHI7wET6ySQF9EQFwxmrI3xWsA4lI9dFWIaim1BxgoFgggaE5vvlKVAMI9dJUPzcuVsfgmiHgxoS/xhkOdFzn90M1Na+3kesO8EsezBTdZYilzo0ndTb+CC+8rqNEEYz+q9VQk/RrORn1zQBuD40nfUutgOAqa6B8HdyoTxIONf1o6nBanqzZPSX8RAHhJ6L/QVMjNfpleLfMHi0eMMDhd6HUNuR7h3uTL5Dvetg2ucfsrQVJbJj5RhbHhs8/PqAzN43hbf3fpyP/xhJIvp9w6xpCYZ1dBjQmvn8mrvFNoElAppn+IguQLdLryu4mkQQ5hgEDXfr6id1e66DxvnIsjb/TfoTuQ9zZ0AEIrqFY1PT3CLV/6ebhV8htj37VneiZCmGcU6SQ4RbdKj3ppB2ZVeevZjJrXizD6L+3q11yj5TxDfU4LjSViSgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(4326008)(91956017)(33656002)(83380400001)(2906002)(5660300002)(8936002)(36756003)(8676002)(41300700001)(316002)(186003)(6512007)(26005)(66476007)(6506007)(66946007)(64756008)(53546011)(66556008)(6916009)(76116006)(66446008)(38070700005)(54906003)(86362001)(6486002)(2616005)(71200400001)(122000001)(38100700002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk1mbWs1SFU5OHZIWFlpaTg1NENLaFJRVFBycFgrc0JRWGZFeWtHSEdkTUFD?=
 =?utf-8?B?cG9vclBYMEhTczNwUXNkTHNHaVF6SC9KUDU2L1FOeEcwQWhuK3VKY3phKytk?=
 =?utf-8?B?Rnp2MStTcFI4ZG5nUTBxSGo5aElxTktGQTlXVFFndTFtTVZWdHcwUThZbm9m?=
 =?utf-8?B?bFpyQy9RK1BVM25YbVYyYy9EZGlwOWo4d1REV0thblo2akJHU2hiYStSMXd0?=
 =?utf-8?B?YlUxTVRsaldDcFBKQlBJQzZHS2hSVG90YThqSjd3c0V6U0k3YTZtcFo1WlRz?=
 =?utf-8?B?cllxU3FoQnVzTVlIc1Yzdm1qOTF2MjJTRUdaOEV6bG1wMk9OTUY2SmIyeVZ0?=
 =?utf-8?B?VGFELzFFa2dBZE1Ybi9FS0pUaWl3WmpoT2h5NHk3cUxBYzdLcS9mVnQvZkRy?=
 =?utf-8?B?SXh5dXJuNDZEVmlRbWdqSUkrbEJEeVBQSHhZWjlIbHN0RFllcllPNlJkYldi?=
 =?utf-8?B?aGZMZHRUd3h4d1UxKzZUWkRNM05zMjkvQ2Rub05ZRmNIUVZVeU8xdUExaUVQ?=
 =?utf-8?B?dmZDWDlrai9RMW55M0p1K0g2VFJuNS9QbmF6WUkxMG9uZm9LKzJ4M1puVnhq?=
 =?utf-8?B?bTNVbTg5VmhIbGJYb3dpVXRiVDJSWnFLU1NLck1UdTlSNFJ4QjduQjVsRkJM?=
 =?utf-8?B?YWtyNFN1eTdyRXVRQ1FLRzRERC9yWU44TldBTklWeVpSQklvMU1oTjZoR0Fi?=
 =?utf-8?B?ejNHd0hTc2syZUFnWHV6bXpmZGJHUCtxWE55QTdSdHpGaXdtVkFhVzQrMU9Z?=
 =?utf-8?B?ZjRITEN3cVU4MU1LbjRsNFNOS25TNnRCOUdMb0hiNXBiSWZBdHJ1VktjTmtX?=
 =?utf-8?B?OTBqNWlkQ0VEd3Z6aCtIQjdZYmxEaGt3bUdsc3U0ZG9rZ2tkY0lRSzVsYUcv?=
 =?utf-8?B?UWNBTHJLekl6b00wSkFFSnJEUWNVcG9FMjRsY29EeWIrVW9yNXk1OTRYTGdP?=
 =?utf-8?B?dHBnRG5UbHllRGR3ZWp4cnozUzlCaFc5NFF5WFRPT1pmUktIRlU5SFdxKzl4?=
 =?utf-8?B?MEpZN3hiMzlHSC9mN2xjNTQ5bFArdHJFLzg0Z2cwUyttcGJRZ2cvRVZ5eEJ4?=
 =?utf-8?B?TnNnL1h0a29hdCsrRU1nWDQ0ZEp4RHhzZk1La2ZoRjkwc3BaT0NmQWlodzh4?=
 =?utf-8?B?YnpqTitSY1F3cDFweEZPZU4rTnV4NDFkMXZQckwvdDNKdVpYODdzWWk5VG14?=
 =?utf-8?B?VlcxQ3ZLT1k0eE5hUUh2SXBYSTdvRjFTeGRUbXF5VnNicHhyYXBuWVRYa2ww?=
 =?utf-8?B?eVpQc2FsQVorMHgwOVVOb2FwSVNuSkhEZjZMVCt2cTNIa0FtRTBSRE5BRTI3?=
 =?utf-8?B?THRaZjAzTTkwRkZYM05wcnRUSGNSdktpeEh6cmY0a2NFSTl0YnB0cTVlbExX?=
 =?utf-8?B?SDNLdUNXRitiMWlCejhXd0pxNi9zRjlRdHoydktkUFhUclJqSGlNMS9wYzZz?=
 =?utf-8?B?c2dZaVFCZ2hYUEc2RUR5UnB1NG5JQ1AyeGFnaE9IajhwbUJqSis2K05Sa1d4?=
 =?utf-8?B?MjVUZUYrcUlvbjc0TkNnYVRjOE5Tb3BscDBUOHdIRElVNXpxVTNuZVcydS85?=
 =?utf-8?B?a1B5d29HakpzSVNJdHcxM3VKdXJZakQ5Zms4VDYwNENGMXBrZGhWT1FmdWQ3?=
 =?utf-8?B?czUxU09GNWVUZmtMVnNMdm8vTjgzeElUdngvbFpBTlY4ZzZjMXVXSjRjTDFJ?=
 =?utf-8?B?UmpiR0xDa2RNQW5lYXBQbEs5OWZjb3FrcU4wM0FvUXA0V0N0eWx3eitzS3h5?=
 =?utf-8?B?YXovQmRHOUlGSWZzNk9ubURNdnVYc1BxVHRGNkNTOHVSNzFRUmIwTk5tcXUv?=
 =?utf-8?B?STZXSDhmZnc2VVJXODhjd0RUaEFBTTEvZzdKelBZKy9SUWJGOXgzYmN3dGEw?=
 =?utf-8?B?V2xSVnVhekppd3krNHdnVHRyNWFhYytwalo5YjVPQVcyUWYwYzBCeTFMUTRh?=
 =?utf-8?B?S2RyL1FFUTVpdGhNdk9GODNDZUxVNnFJZURWUXVRNHh0cWFrbVZiTjh6bTQx?=
 =?utf-8?B?cHpVbGFQbUJSWlZpUCtRclcxL0M4K3VzTk9PT2N3djk1Y1ByZU9tQnk2cndV?=
 =?utf-8?B?bXRlUGR4UEhJTi9La0ZPYXZ5aUpRN3llbEVaZjR1ZmpQNGx3a2tQS3VET1c5?=
 =?utf-8?B?NEhNTGwzUkIxa2VJVHFxeGIrVVUxdElQbUsrRkc3WnAvYm1yMXdNS0lsbzVK?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32861AFFE6043C4788CF1550E993EC7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UK9dcga3aQ6Jx+pwlwQvCbvY2eDbhNx15rwHnffvdMD6WwO3f1WeSUJo8+zYq8Y1uL1Ve2v39wDs6ldWgGibAJjt2eREd1Hs6K/qwE10RICSvy3byzgBRizo/+Q8019j9c34Sv4Mp6eWw3ni/UloCOEMKpRz/faAGyA4GbiVyItFxu1bsSePmKolKWt/E3zmhhAP0jLEi/faco67xlanpHBDkoqllH3LPhTH69a/ijza6OjJO1iC/RrUxbH/BMvCqZoYEvMbYmEDWYW4lCYLUUW647SeslwgSgUehxGzCRzJO2FMCZinmOcrN0zfc4B3q0SbIXrAZh5nQ57ffOh+4U4da3gRqYTUaOh68wMRPKEdNz5V+BSQAsXI4vc655NlJ/o81BuApq6DGf+rQxY/bsi7nffp3lb1feGuXJVLqRYBeS22OhVT+YzoXIBqlf5si7EREVBnLm/UMNB9z8SR3+jJHWj0oKSkE2EzPW1OkDb/zk3XvAUxfmdTcx1tf23g4S0OyO2Fcs5H23X3CLRjYcN8f512sj3bB0QMEPSB/t9JXNWP4PWZ6jZwqL+YtfBLKD+tsLnPNnrxXg6CQYWvlJo9nZHGXef+gv6AaTcqZEJkzAU8m0OFZq1iHzHk/KieSdsBQ1PVenRYzlvh0U0veinP6k4H0+gcATGyXfwYm1SkTcYEhtIJh+y7W7xBzqbP++d9OFZ5gqd/N11VO1ZPH4tfM1q+271AhJpOC0LGbcWk+AIXU87Y+YInmA5n/C/G6R4rotvVJGlkiAjSjMdhxPIPxHphg6TGqpxbg9LWneeucVZ0ReZklmwEIhYyiL61ioCjK2RqH/YRybZlobL2OK7DFyI3yDcp2i+SdYJNzEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3530dc-eaae-4ba1-0773-08db4b467154
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 19:50:12.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPdevo6dHRUtNyhSNRcuHyVYIFI0N9oycsLpZywc+8vziX4f2gR02iz623cy8Ed00P7UzdGUHmwcC8HpQKEIOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_11,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020170
X-Proofpoint-GUID: 3c3qUkkuWbvVLcQ5CG7yeb8wz8tUIXcP
X-Proofpoint-ORIG-GUID: 3c3qUkkuWbvVLcQ5CG7yeb8wz8tUIXcP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDIsIDIwMjMsIGF0IDI6MTYgUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDIzLTA1LTAyIGF0IDE0OjA3IC0wNDAw
LCBUb20gUml4IHdyb3RlOg0KPj4gZ2NjIHdpdGggVz0xIGFuZCAhIENPTkZJR19TWVNDVEwNCj4+
IGZzL2xvY2tkL3N2Yy5jOjgwOjUxOiBlcnJvcjog4oCYbmxtX3BvcnRfbWF44oCZIGRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1jb25zdC12YXJpYWJsZT1dDQo+PiAgIDgwIHwg
c3RhdGljIGNvbnN0IGludCAgICAgICAgICAgICAgICBubG1fcG9ydF9taW4gPSAwLCBubG1fcG9y
dF9tYXggPSA2NTUzNTsNCj4+ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPj4gZnMvbG9ja2Qvc3ZjLmM6ODA6MzM6
IGVycm9yOiDigJhubG1fcG9ydF9taW7igJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9
dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0NCj4+ICAgODAgfCBzdGF0aWMgY29uc3QgaW50ICAgICAg
ICAgICAgICAgIG5sbV9wb3J0X21pbiA9IDAsIG5sbV9wb3J0X21heCA9IDY1NTM1Ow0KPj4gICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+DQo+PiANCj4+
IFRoZSBvbmx5IHVzZSBvZiB0aGVzZSB2YXJpYWJsZXMgaXMgd2hlbiBDT05GSUdfU1lTQ1RMDQo+
PiBpcyBkZWZpbmVkLCBzbyB0aGVpciBkZWZpbml0aW9uIHNob3VsZCBiZSBsaWtld2lzZSBjb25k
aXRpb25hbC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29t
Pg0KPj4gLS0tDQo+PiBmcy9sb2NrZC9zdmMuYyB8IDIgKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZnMvbG9j
a2Qvc3ZjLmMgYi9mcy9sb2NrZC9zdmMuYw0KPj4gaW5kZXggYmI5NDk0OWJjMjIzLi4wNGJhOTVi
ODNkMTYgMTAwNjQ0DQo+PiAtLS0gYS9mcy9sb2NrZC9zdmMuYw0KPj4gKysrIGIvZnMvbG9ja2Qv
c3ZjLmMNCj4+IEBAIC03Nyw5ICs3Nyw5IEBAIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIG5s
bV9ncmFjZV9wZXJpb2RfbWluID0gMDsNCj4+IHN0YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIG5s
bV9ncmFjZV9wZXJpb2RfbWF4ID0gMjQwOw0KPj4gc3RhdGljIGNvbnN0IHVuc2lnbmVkIGxvbmcg
bmxtX3RpbWVvdXRfbWluID0gMzsNCj4+IHN0YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIG5sbV90
aW1lb3V0X21heCA9IDIwOw0KPj4gLXN0YXRpYyBjb25zdCBpbnQgbmxtX3BvcnRfbWluID0gMCwg
bmxtX3BvcnRfbWF4ID0gNjU1MzU7DQo+PiANCj4+ICNpZmRlZiBDT05GSUdfU1lTQ1RMDQo+PiAr
c3RhdGljIGNvbnN0IGludCBubG1fcG9ydF9taW4gPSAwLCBubG1fcG9ydF9tYXggPSA2NTUzNTsN
Cj4+IHN0YXRpYyBzdHJ1Y3QgY3RsX3RhYmxlX2hlYWRlciAqIG5sbV9zeXNjdGxfdGFibGU7DQo+
PiAjZW5kaWYNCj4+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+DQoNClByb3Zpc2lvbmFsbHkgYXBwbGllZCB0byBuZnNkLWZpeGVzLiBUaGFua3Mh
DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K
