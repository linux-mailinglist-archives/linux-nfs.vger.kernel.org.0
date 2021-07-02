Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C53BA2D1
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jul 2021 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGBPiP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jul 2021 11:38:15 -0400
Received: from ndmsvnpf103.ndc.nasa.gov ([198.117.0.153]:54494 "EHLO
        ndmsvnpf103.ndc.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhGBPiO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jul 2021 11:38:14 -0400
X-Greylist: delayed 1452 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 11:38:14 EDT
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=2a01:111:f400:7d04::200; helo=gcc02-dm3-obe.outbound.protection.outlook.com; envelope-from=jeffrey.c.becker@nasa.gov; receiver=linux-nfs@vger.kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 ndmsvnpf103.ndc.nasa.gov 1C3604008DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov;
        s=letsgomars; t=1625238689;
        bh=IbUMivMR2bBEsxqDnVv1g4LdXCL8myGyAK0hkxcTOu0=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=e4UTr9FM8Z5xhGwfQTD1d9JVFP6c8Pvv+RA1A0EInOLswKVtUNvOQAPMnEKiTmR1D
         9s5boXXsRkQEVRdQgwC0DBf0pXH4cueab12nwXBSby+6vWu5owge12PF+EuCWja+d1
         onxKpKSBG+791PvbMdebr3ypLodFVMCWgaG7l3fNI6LU/8XASzZXLh1jeiLTBOJPFA
         oio+JChp7fqWqq+qTadbbbn9rwxp3wAm455uSXg9B7tWJqI9pCgDw4mZt37ttcGvAU
         4TlFp+vGJ70OVNW5iWOAvHqbK3AK7PsrPf0Xq0SN97c5tCVr4lhyyVVyV71L+GLlU+
         Wre7ZTdHoQLAQ==
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02lp20200.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d04::200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ndmsvnpf103.ndc.nasa.gov (Postfix) with ESMTPS id 1C3604008DBB
        for <linux-nfs@vger.kernel.org>; Fri,  2 Jul 2021 10:11:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlieOh94pt+Tgzf8fYmtS0pd4TkokdU6vGRyxTV6Hv9HV9INmKDREg1/1ljuy/UZ6ovf8B5N/W2xURKIk+l8bwwP4TkngYiiFQuQlMuSHevdZBOUfRyQETcYFEMZvTzut6Eho2JzVOV1bHpz1F+yk2axnC0sGIZhOqOJcYAlyIObThYX+zIWhDXKs3SSGX31og2B68e6faGvsqB7jdb7g9rLW2oKDyNSlRoLEL6jlHVoO/+xg0MukucXtqC63x3dp5Yy1f9Zt4pulSoYxlYpj7BzwJfwzTEXj15bChzN0aBI7JSZjUz1SzJpmfTFcnIYn3WGZSLqMYra6M857M9F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbUMivMR2bBEsxqDnVv1g4LdXCL8myGyAK0hkxcTOu0=;
 b=gF6CBcfjHmG9fiXecINXa1cUJnKfRIJUgZV0DNQxHLtdzRPc5qEJytgdNqzK2slyi0FeiNKNfARelu2PEkEX/bBzqHzU7T2mRemL4iKsd51MzE+Tl9EgtbtseCT8Q2UR4kKya7gA/0SIbKFbf9OPMyR1Bi8JFQcGSaj4tiFCR00dYbkMwV21rFnjIxcB0ZbYlDu5sDNFtmZJ9cqsvrknImeICthPsGHBXNgXRR3JIzrj8MIDQ/b/sk16Bas+E4nL90iFcxgX25r0bDei4SiZmotf/vaW1XIPDJHYxXWpZzxB0MfRkIAo2JrlzxA1eSBevgC0s+fkuIx9gBz2cp8Jgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbUMivMR2bBEsxqDnVv1g4LdXCL8myGyAK0hkxcTOu0=;
 b=CzHrsDTInZ4+noQcntprNboqS3I2AwoES3tr0k4IaxWBdkXIqQr7RkSTDfa97FHDe1JQkdDzqy7yuS7sdrH9s8IEsvyCFduYjdcl2tiwe55x0SArjxJLY36aa4iWONtSWF3ngf9s+KXSC8tPkveYQvp3p5pbQ1FsmXbuH+z9PL8=
Received: from SA1PR09MB8157.namprd09.prod.outlook.com (2603:10b6:806:178::13)
 by SA1PR09MB7677.namprd09.prod.outlook.com (2603:10b6:806:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Fri, 2 Jul
 2021 15:11:11 +0000
Received: from SA1PR09MB8157.namprd09.prod.outlook.com
 ([fe80::b55b:1088:e265:c983]) by SA1PR09MB8157.namprd09.prod.outlook.com
 ([fe80::b55b:1088:e265:c983%5]) with mapi id 15.20.4287.024; Fri, 2 Jul 2021
 15:11:11 +0000
From:   "Becker, Jeffrey C. (ARC-TN)[InuTeq, LLC]" 
        <jeffrey.c.becker@nasa.gov>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: FW: [EXTERNAL] Re: NFS server question
Thread-Topic: [EXTERNAL] Re: NFS server question
Thread-Index: AQHXbtRwHnHqdkeFf0avCJtZEgrXbasvvWoA//+YjgA=
Date:   Fri, 2 Jul 2021 15:11:11 +0000
Message-ID: <C88E1CD2-4156-4E45-AC27-F19D4E4C9FC7@ndc.nasa.gov>
References: <0C9D9022-8E61-4B03-8225-D829E22B4137@ndc.nasa.gov>
 <E168219A-8120-4154-80E7-DC03F70D69D1@oracle.com>
In-Reply-To: <E168219A-8120-4154-80E7-DC03F70D69D1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.49.21050901
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nasa.gov;
x-originating-ip: [192.92.190.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa4b2ffe-e3a2-40e9-4593-08d93d6ba0c2
x-ms-traffictypediagnostic: SA1PR09MB7677:
x-microsoft-antispam-prvs: <SA1PR09MB76775ADA6B7447CDBACB0C0FAD1F9@SA1PR09MB7677.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5njwb7uxYt2/Hzei7+KitsP27rlnZkkFbWI4e7FlFGUkVid2/D/Hqkz2AbaELHyjlha9n2bcOOW0I346CGYJvAiGabsRvsUrJWomQtHQtoWKN3G+MqpxebBUDyr4apL7G2gYBLulHw3fxGJ5QfKvbjmxAp6oQA80EpB45aKpRJYpzeq5d6JAzgjJxfPZfu6+77ejVUnaiHx3b4W4nvj4ZMDFVg9C2xGdEg4BFX7ip9fBlhHag68dG3ikeNoLr3Z+49ukoLORlaeTi8LR/VAJxkYkfEYEBkcRr8Kib2iCPUtKkWcJYSlG2+XHfl8xGq1LnCXCkfwP6n5l85Nud/zoVApa6soqw7JnrUqZCl/ZCAknGXB+fQzEMOgqJK5ReCAJOxm0mPuRyw6bRJZyUYvPt0g2kRBtDqR+aSlqljmyAmwrTojUWgydsrMkIpxZWs4j2GU7hw83sWlDc/LTz7HKENi8Sccclmmkee9s2Nf8icwg0+DO8UgNP+9/st/jNkFaRoQ9QojjYRydUo1inf3OJ6z6e7uujfi4YSz3uAZrYv8dhLxuR09B8FxWxQqK55pkErujTzhE0bHkPv7uJB6fRLDr254axtfUYhN8DrUe963iKU75PQZM+jq2K5X7uP823unVdtEdjl4bP24eHJ7Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB8157.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(33656002)(53546011)(6486002)(6506007)(316002)(83380400001)(2906002)(86362001)(6916009)(38100700002)(8676002)(71200400001)(122000001)(186003)(91956017)(66946007)(76116006)(64756008)(66556008)(4744005)(66446008)(66476007)(26005)(5660300002)(6512007)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aCtiSnowNjhiWTVhc1dwVVlJemtPcWRDazNhNXhIUG9GMWZoT3laMUN6RHFx?=
 =?utf-8?B?S3FDS0JsQzB1UTNXZFhEdUZIb3RwN3p6eEJlQnhqcnVnWERBK0lZWU9wRURm?=
 =?utf-8?B?ZC9KN2grWUhNTVBHZjVzR2ZKZDZDd3Z6dlpIMjlkZ0M3R1dtMjV6WVBMcHE3?=
 =?utf-8?B?b0lOTDViY2NhRTF5RVN3ZCtOa2dlSGlDaWMvRkI1WnN5WDRvMFFuZlNrMm1S?=
 =?utf-8?B?aVdzdjU2T1RCY0QyRTc0UHdYTVAyNGZBaGRnYTdpQ0JCcW1BU2M0ZG0wbWhU?=
 =?utf-8?B?UE90aDBwQkFIeTFscTJJSHBuSnVEQlc4WnoyVmdMTlljc1pGNFVKSUlMeGRw?=
 =?utf-8?B?UFBzTEovMTNXQUh6YjVtaVRnZG5KT1RMTUFxNXNhbldEckRtTWlRUzNqemR6?=
 =?utf-8?B?WTNvWWZEOHc4bkltRTNKamNlY2N1anpCbTVIVW1sUHUxTG1OWFFydnlFUFBH?=
 =?utf-8?B?T1R2VktvZEE4bUlHMVB2UXRmVndId05POVJ6WmZTSFRQd3QyYmZuRkV2OVZT?=
 =?utf-8?B?RXFEVFl4RjdPWVpOZE9lYkJoL2dkOW9sQmNlc1pleHh5MTQzdDlUa0N6cmho?=
 =?utf-8?B?WE5CZFA4V3lNK1d3d2xNTUo1SjZUc0ZtelNQSnpOcHF4djR1SG5KV2tFMFg0?=
 =?utf-8?B?eEJubUg0TlhHdVBTUzcvS3FKWC9xZWFEQVRQODluT2hrRW1yMDlDOUNKUkky?=
 =?utf-8?B?SEZYd1JGTnVyakdpeGU4Sy9kUjJhQlE2VHFVN3ZEWXdYcEdKcnVGRDhIM1pF?=
 =?utf-8?B?SFBreXVCWVFMV2hQWHlDVkRxVFovc0luR2wxVkhvdHJtQllyaURUMUFqY1Qz?=
 =?utf-8?B?MGhnY3Iwb0RVZzdaMGt2TU5BZ0JFM1RXZHA4N1ExWDdtNGV1dVlkYkJwNnJ4?=
 =?utf-8?B?ajRsRGNMemd6RXltYmxiRVdFWlZncS9zN0hYMjRnS2JROW5ZZU85d2xEVkhw?=
 =?utf-8?B?T0l1UzM0dUlNbzRoUWVGdUtyVllncHBxOHphNStiWVdDZEdQUXluVXBqQkdm?=
 =?utf-8?B?ZVhSdm1FOTZGNmFIcU91UTJOSWlYOXJFcVp4QTMzNGxpL2hibHlocFJjYmZn?=
 =?utf-8?B?dVZOTkVuWHNtZVpEc2lOYXlhT1k3dytna3FwSUR6MExiMjY0eHpQOFozV0Vm?=
 =?utf-8?B?YUp0QWV3ajdjSmVaS2I0TElOWmFRcnIwYnhLL2VpR2l5aHljS2UwOThnczVL?=
 =?utf-8?B?eFk0bWl0SGdtOXBPaWpsbGFVYzNEL00xZGlaTUpXUkcvUGNVanpWY0ZqSlpW?=
 =?utf-8?B?MDkzUjZHak1xL2xxRGc0aEtQWmdxaEtOVmlhSklkMXUzMm1sMUcyRjEvUnNx?=
 =?utf-8?B?dGVvQm5PTWphKzhXK0NCYVhBZkRKd3RQRWxON1Y5Q3I0U2FQTzJqUUc0NU5i?=
 =?utf-8?B?S2VhTmdMa3h4NTQvc3F6cG1hMTE5V3IyMkpsTXVhNk9lalkrQklzMDgxd0RS?=
 =?utf-8?B?VWFaelN2aFlISnB5TkU3ejhUaWtqU3JZRVowbTQySjFRcXR5U3ZBYmxYUnlK?=
 =?utf-8?B?cDk5N0VRYnhVdnBnRFF2d3oyWUUxWEZIMWJyWHBOdS9yaFpVRUhEYk9CWHZr?=
 =?utf-8?B?Mitxb3RlWDJMYU83SStDMW5rQm5MK0I4QUVobUlIZUxLKzkzWE01VnpST1k0?=
 =?utf-8?B?ck9aVENoL241NTdiMWNEMkRIdkpUaVhPZisxWVhCMWVOZjlodzg5YzVmOGJT?=
 =?utf-8?B?WlNxd1ZXd3JlbEFxTXBFcy9SZzM5RThEUW82YXpBeVNOazg0bXFaMmJ4SW1G?=
 =?utf-8?B?Nk5hc0VvTEtNL0orcFREWU1DUXpmWU9RMkI4aUhvL21XWWY2Ujc4ZXlkc0ov?=
 =?utf-8?B?SFI2MmlIM3Ixc0NRTGhYUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C907C0EC704614580B33C74884E43A0@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB8157.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4b2ffe-e3a2-40e9-4593-08d93d6ba0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 15:11:11.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB7677
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGksDQoNCklzIHRoZXJlIGEgbGltaXQgb24gdGhlIG51bWJlciBvZiBleHBvcnRzIGZvciBhbiBO
RlMgc2VydmVyPyBUaGFua3MuDQoNCkplZmYgQmVja2VyDQoNCu+7v09uIDcvMi8yMSwgNzoyMSBB
TSwgIkNodWNrIExldmVyIElJSSIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KDQog
ICAgSGkgSmVmZi0NCg0KICAgID4gT24gSnVsIDEsIDIwMjEsIGF0IDc6NTQgUE0sIEJlY2tlciwg
SmVmZnJleSBDLiAoQVJDLVROKVtJbnVUZXEsIExMQ10gPGplZmZyZXkuYy5iZWNrZXJAbmFzYS5n
b3Y+IHdyb3RlOg0KICAgID4gDQogICAgPiBIaSBDaHVjaywNCiAgICA+ICANCiAgICA+IEkgaGF2
ZSBhbiBORlMgc2VydmVyIHRoYXQgY3VycmVudGx5IGhhcyBhYm91dCAyMCBkaXJlY3RvcmllcyBp
dOKAmXMgZXhwb3J0aW5nIG92ZXIgTkZTdjQuIEkgd2FzIHdvbmRlcmluZyB3aGF0IHRoZSBtYXhp
bXVtIG51bWJlciBvZiBleHBvcnRzIGlzLiBUaGFua3MuDQoNCiAgICBJJ20gbm90IGF3YXJlIG9m
IGFueSBpbnRyaW5zaWMgbGltaXQgb24gdGhlIG51bWJlciBvZiBleHBvcnRzLg0KICAgIFRoZXJl
IGlzIHByb2JhYmx5IGEgcGVyLWV4cG9ydCByZXNvdXJjZSBjb3N0IHRoYXQgYWN0cyBhcyBhDQog
ICAgcHJhY3RpY2FsIGxpbWl0Lg0KDQogICAgTWlnaHQgYmUgYSBnb29kIGlkZWEgdG8gYXNrIG9u
IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcuDQoNCg0KICAgIC0tDQogICAgQ2h1Y2sgTGV2ZXIN
Cg0KDQoNCg0K
