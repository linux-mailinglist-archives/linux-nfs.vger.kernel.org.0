Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A104F9953
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Apr 2022 17:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiDHP00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Apr 2022 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiDHP0X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Apr 2022 11:26:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF21DB5;
        Fri,  8 Apr 2022 08:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2tqq51MULoczBTjJEO0R1ZRGr86wDqR3K5fAs5VFxEwaLnezSbEfpZCpP7EBI2P6fuKAJu6sUAj5jVLbDvqf5bpCtpDL2xhsD7XlTtDTLTH90V6wWglfx404rcwPusN+OFruJ7LHWXigHs8kYUDWrC/s+ak73OHVJLe27riUZzwGC7XurIJq/lf8HP2nou06WrIxYleSRw/uX7sUJojNqsBf5nLa1kqy27/QXU6eDjeuyiaFD6Kf7X69RqzCU4vwg8K+P0QkHHE/8WQcbuJZiy6V3o8pxmtfKmnzBAMOe9gQe6uHyJ+OWPjTncL8qNRai3aT0v6Y/4kCc2TSO3Lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbqz1BBZAMm2fYEgCp09Pd45ZCRYjlQdLE78GOhgosw=;
 b=Hd8YZSo7UDnQ5a8Pqs8uWFp8e76L4YscKP4bhdWGKMQgg/tFQbP3yOvgNr+Jitka9w2Aeg7g6li7hIufUpjOfOUOJxo9qK3cOt1jFzkq9ntJ3pS64rda393QVQE1MD/pHmp9AxmzGYVcD0v8mZyv/xeijF2lZwmdMF4tmnrcZBh4ExEG+x25puqmEnCljgzgGNIz0BevAeE6LIjgdBguqq4agd07Qvvub6kaatmj+RbjifFLj5HELjuDX2AtKFpf4bzpYp1gXPTqIvRYLevuJHb5KF4KL39rNaG4iKMb6Am7BYyzT4zD2z+s7NeAtP5gORMzFARTdOc2LNGjyfIe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbqz1BBZAMm2fYEgCp09Pd45ZCRYjlQdLE78GOhgosw=;
 b=VqpbMEhjxljtC+NKyS0Slz5cbVg3NCoTUTZLY+ggdFsSngUjBiflbF9rV2dEmnf6LyBXDmMnoH1fkItkTjGGWIaS/gygTZPZ5brsKcRhXW7RmoYA/dpFSuQUBsokglvbKPoH2V5A6Y7ZJW+5KMIo2G7pyghQ2M9fHTWJ4c1YWsc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1819.namprd13.prod.outlook.com (2603:10b6:3:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Fri, 8 Apr
 2022 15:24:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5164.008; Fri, 8 Apr 2022
 15:24:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "smuchun@gmail.com" <smuchun@gmail.com>
Subject: Re: [PATCH] NFSv4.2: Fix missing removal of SLAB_ACCOUNT on
 kmem_cache allocation
Thread-Topic: [PATCH] NFSv4.2: Fix missing removal of SLAB_ACCOUNT on
 kmem_cache allocation
Thread-Index: AQHYRXR9iRJLTgUd4kyuUxjBz0uuOKzmLaCAgAAA3oA=
Date:   Fri, 8 Apr 2022 15:24:14 +0000
Message-ID: <6c1181826d5fa8f2cffcd9cfdcb717c5cc3416fd.camel@hammerspace.com>
References: <20220401025905.49771-1-songmuchun@bytedance.com>
         <CAMZfGtV7Uf3Z1G-0WQNe_DukPz4t5HuxPRrNMVLJ1GVST9jQpA@mail.gmail.com>
In-Reply-To: <CAMZfGtV7Uf3Z1G-0WQNe_DukPz4t5HuxPRrNMVLJ1GVST9jQpA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e97546a7-8584-4ada-42dd-08da1973d6eb
x-ms-traffictypediagnostic: DM5PR13MB1819:EE_
x-microsoft-antispam-prvs: <DM5PR13MB18197F3DD7523BBAA0B3A46FB8E99@DM5PR13MB1819.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKflG1nvGbJ0Aw1bo2baKblD1szsXQOyjX90TXqLGRVdwkJLz5gcoNl/U1jNct3RTY4x5cnQQXobyoaNc7RWF6NaAxhuMDy7FQBSdNBviVLJOr9CImzM8Hf7qBBKemoGdv9V8riCeubb8Y7ievyUqQ2aNLSu4hTPfHGJWrZIDFnhfvtQ44ZMY6WsDAATjnM+0P797h+hgkHTwyattCMImzCUFR2KHkkY7TDYrQ98bsfcwlB7E5Pa5mU5pJMU6Hr6ebMMagVQxm731R8uf7KH15Ig0EIsH+RqLoF68ZQPlCHSP4hvqbwBsl6SZdOqDbs2b4Qn8AG691vlkkA4wfq4Rd/rXGcmWHpQCbe/XkXsJhcXrBcu/DoXpsI0N9HGSQxIpla2ZY/lwlRqrvaW33S1J++K+WTh4ymQI09kHi/kAcVBKQrhgjUTKV1AgsXcv4rZR2W17wEqDE/WPBsJ3DKJbfM2wZ0MGXpiDSe2/x9k+R6qrIVGJ4Zx8xUtjpNa/lcIbfSV2oH/3RRuJLWQQxi1msMf5196MWw4FMepRsDAq020gIHPwHlt4sLrV18j7HMysLTB8Nsa1RiWivTdnJbxxbPXRGkla0SkOZCiOvqD6ZESaPUU8TFLEtG3kPWVCfDeDISE+MMvWIjlKzkmwmv7caQ/YbchhDPMiVOivM0fwkDg2gd9ONRfj6DzuKg3zmFL9Oq94xk10U2zkCovanxdnI58O02MUr4IQ63rz9iA50brJXDiE+7ZfEe50E7d2n6s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(38070700005)(36756003)(8936002)(6506007)(66556008)(2616005)(508600001)(122000001)(38100700002)(54906003)(316002)(76116006)(66446008)(6486002)(186003)(26005)(6512007)(71200400001)(66476007)(66946007)(64756008)(8676002)(4326008)(5660300002)(2906002)(558084003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzY3blIyaHFJSlRlWDZKZlhlYXNUWGRMTlBVVmc2aGJRVUlRZVNyMEo1Wjc5?=
 =?utf-8?B?SVkzeFpyTEtJT0Q0Qk9JRXhZU1cvUWNyYmhUM0VSb2xqN0FlL2xsWi8zQ1hX?=
 =?utf-8?B?bTRMVkRnT1pDT1dqcmVwMzBNOENBTCtJRTBXeDRkSnZxdDQ0Rlpla1JTN3ls?=
 =?utf-8?B?ZnBtZmx6elJoRkVBTXBUUzVySURna3kvQm80M29pU0FqTEdTdlBaQWlZa01o?=
 =?utf-8?B?VmZEZ3oyUWhNMHBFYkd5ZDY0UDd1UjdpM0UxYUtDcnBWTWd0S1VvbGNqdHVw?=
 =?utf-8?B?RkNMWVVQeVJNS0I3T2xnakJnd0I4VU5oQzBhRjBtZG1ZUkFLZnloK3ZjOGxx?=
 =?utf-8?B?UjVSSDZHcjgwdzI4b3RGU21UdUt4SVA4MlFRTW12eWRDWWczeXRRVVF3dW5z?=
 =?utf-8?B?eVpGWk5QUmEwbU42NDA1N0xLRXdaWGhwL2FESWNPb0Q0ZVM4TEtzQTQ1SEh3?=
 =?utf-8?B?VDAzYzh1MFlOcC9aY3ZvTlNRUXJrRTk2K0E5MnpDUTl5THozU0UxRmJnY1VN?=
 =?utf-8?B?VXNLcUZPTWJEaEtmZGJiSWRIZVJmTU5qU2w1MTVVWG1nVTNKc1ZvbTNUM2V5?=
 =?utf-8?B?S2RZdDd1cmRvRVRaRlorOEpML3pBQ0ZDVVpBRjVySmtjaGd3VUY5QkcrRVN4?=
 =?utf-8?B?c1hReU82amc4NndKU2lJdFBKOXBGQWp6WktQUnN3YUhLVVdQRjcwQVpVZGY0?=
 =?utf-8?B?UDd3blh2VXd3MWgvNFUzcGRqc25DeC8ybDZUaW9Jd0xwUGZUY1IxQTdndVZV?=
 =?utf-8?B?QkxnS0hCSXIzRVRSWlo1K2M3bGwyVjZvV3plZVVsVjdOK0tHSUt0ZjZxdDFa?=
 =?utf-8?B?eHhaMC9vNVExU3Q1ZHBHZUdOTTQyMGNNTmozdXVFbHFob3kwY3BnQTlKK0Vv?=
 =?utf-8?B?ZWM5alIrNXc5Z0xEUU9sTEl3bVBISXBlVmUvYmUyT0NYZ2RkakZiek9lMmlR?=
 =?utf-8?B?TnNsYld4TnRnazJDRFY2aG9RWk1ZZ3lxaHBmT1NZSEo2WTcxLzM1OWorT05V?=
 =?utf-8?B?aTdJU0J4Z3E4TmFqUytwT0w3OUw1cThYZGdZdStDQVU1eDZHeDRub1JkbldX?=
 =?utf-8?B?ckd2VG53eFBLcGo2NEZWQ1FFWmFNVVp1OEZYRXkrU3hJR0g1QkgyY25hTE5n?=
 =?utf-8?B?TG9ZYWN2Zm45MGdFZFg5a0VGSFNXSXM0RTZyOEp4Umk5MmY3SVBleWNrUGor?=
 =?utf-8?B?L0R0cmcxMmtCb2MwbGRVMGZuZzFMaFg3c3NHSStWR1dkVHY3QU9WRFNid1k5?=
 =?utf-8?B?UVZzNGRWMS9lRWtDQ1cwZVhGa3YyZWxHRzR2OFpDT1ZybkZCeGl3bEdGOGta?=
 =?utf-8?B?ckRPNnJjNFVPY2QraDdpSnJYcE5vNDVGK29QbDYvM3FkN2dRSG0wVU04U253?=
 =?utf-8?B?OGJ6Tm1RalF6cnpkSHRXN05IcmRzR2FzLys5NnNpY3dUWGVXNk9JN3FIcndJ?=
 =?utf-8?B?T29QcEtQNVZuM2tOVkV4dG9yWW1RVTR4dTNwM0thQm1EV2k5RVZUUkNhUVk4?=
 =?utf-8?B?TUk5RC9LWVNJVEp4OStkUFFuT2JuTUdNczYzU3RZa20rZXpDaHN3eStMLzlV?=
 =?utf-8?B?VnU1bFR5NmZka1M3cUNoczhpMlk4MWxvdmxWUmxxWisrc3dUSDJ4TEhMdlpF?=
 =?utf-8?B?aDRibk5KeWc4VWY5NmZHcm9hNWJYc211bThDaHVSZHU0NkhablgwY3djdGI2?=
 =?utf-8?B?UnA3Wmw2ODRCblVsbG84WDQvOTVpU1dkcktVL2JFTncxdTFNQnJrTW1CY1B6?=
 =?utf-8?B?ajRmbU5rMUdOdjg5cGoxdC9VTmRxOGhuY2gySWVrMWlRR1Bmd2N5VThvVmxv?=
 =?utf-8?B?OUNvY2xheHd6UXRVb3pRVFZVMENjVWR4bEhwQWppUnE1dHdRQ0dDckpLY2V5?=
 =?utf-8?B?Q0VXOFRlZThoWVlhbFNsdG1JSEVQdndDNkd0Ly9zSnpNTGUwL3g0dWlDbFUz?=
 =?utf-8?B?Q0UzRW1lNGlMQ3NubHdXVGlYdGp6b2VwVURnRGVpWGFSYlVQeFJhUTd4VDhh?=
 =?utf-8?B?b2p1QWZ6N2hwNGlMekRmc2VWNVNmOEJQOTA1dnRLeG0ybGh4QzJBRTJOZDZ5?=
 =?utf-8?B?M1VNeEw2QmozckowM2lFcVRBY0dtdlZrbS83M2R1Ujk0VG5NVFpPM2QwR0pk?=
 =?utf-8?B?UXpmY2hhSU9uRjd1Skxvdm0vYWM4VFVLRzFNODhoQXVaakZZRisxSnNuTEJ4?=
 =?utf-8?B?N3pNL2VoSDluSEpuZDJpVkRkaXVDMVh1dXVMZG1LVFo0cS9mckJWUTR4L2F1?=
 =?utf-8?B?WnVndjlWak85bFRNRXBET0FSN09xOU9GVW1Yb3hTWkI1bGZJODdnTjBBN25U?=
 =?utf-8?B?ZE1DSXJZeGRKbUhOcXJSRzBjQnNvV2hDbHFjZERvN0lDb1Y0akhacGw2ZCtT?=
 =?utf-8?Q?EwdBkvl6hMfKfrPs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE6C4DEBE8F5094A94B3A69BD4688F19@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97546a7-8584-4ada-42dd-08da1973d6eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:24:14.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlvz3Mma82AQxptga9gddBBrN566IZsuKEMUMTjEqQ3M0ZaPANnK7hPFXCE8TWgtf4+YtrSMejx7CTIixGgcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTA4IGF0IDIzOjIxICswODAwLCBNdWNodW4gU29uZyB3cm90ZToNCj4g
UGluZw0KPiANCj4gQ291bGQgc29tZW9uZSBiZSB3aWxsaW5nIHRvIGhlbHAgbWVyZ2UgdGhpcz8N
Cj4gDQpJdCdzIGFscmVhZHkgaW4gdGhlIHF1ZXVlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
