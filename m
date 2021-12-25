Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989347F4A4
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Dec 2021 23:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhLYWxp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Dec 2021 17:53:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36384 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhLYWxp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Dec 2021 17:53:45 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BPH9sOG022780;
        Sat, 25 Dec 2021 22:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+fgzDTrdS+dvEshZx/s0t9a1WWKep2aiZEkrohUzeBM=;
 b=1HhJ28A4k/GN17YodFwp1sqpqT9kfKzsotToUsbAkTk8ascJk1JRzGAmJHnmafbvyFYL
 Euabpzj23tnNBZSJLIbyuJR7iz/IOoI9qV9kKRnOsf7Hn0lMBKbFvQVqDxHjncERw2jS
 +esG0uz1LBJoopTSb4KDBJLknGVKZ2LicoRbwri0cV+gEYbT1Cfx2p2ni4yiG8bJTKEz
 9I0ZICET1NK3dqWXHK4bGSWiK+13j/ylxnwxkOSYTSCHaodPtIAIS0grc7N6cMuhZL6J
 Uiqe8Oy3MhZNxUB9ii/CvFCEfRallcWyTv4iPuPYekQUOtGnmo5NvRe6jbujlT+DYI80 RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d5sw1rupa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Dec 2021 22:53:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BPMpK2Q116924;
        Sat, 25 Dec 2021 22:53:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by userp3030.oracle.com with ESMTP id 3d5rdt6tv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Dec 2021 22:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBCYK/LZHehDuP10tZdd7rsbP652vmsCt4qW3qaArpANGu5mWGG+AoDbfyhocMl6xe0X1h7LuRefYAV0SKzcaP4YvSrGHpN5grEtx/89DiLuEW5QmAMcgdZ51qMwDqJJkyZDU+H5g3ja3jJnAKNLz5MfbHWDwQkAD7vhV9WAExUAsFumDvG0jysrVLWPBEuwR9Ph/2vEqocamVEo6Baf+jQk15zVgOIjeIU4LBGDvN7gyd388yj25ygaw3QqsphmG3vOMN2GNwg3hDEI4W6g/Xml2+BWirUlOCV6qJPzTDcVSufMDbZMOAlQffznIKeDvBgQ1vErhfBb/nJGaLDuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fgzDTrdS+dvEshZx/s0t9a1WWKep2aiZEkrohUzeBM=;
 b=R7weSczfNsdFq6cae551PKCQfxYmz06PwDg0bmf0PN3QqRbuLQ8+rY4bwiPbavFsifOVuu1f/wwtUIzNSZEQbE5YFGlg8siHTHdACw7uTnIGZgZ5GvGxGgAkNb6Gtx6nn7BUoQpzKciUMuS6d/eIwvlzwpIPz/BrEIElXasB5SLP//6LnOb5R79ZNpDulgSbROAAf1eBsFF6o/gOjDjoAH2tTg61A5SRjIB6TfYLB4XYGS67kH+mHNx2wzl8pfNlaCirbsyLId+SzDHPNm1USaCSE9Q6trpBcBthzIhkr0z6Lk8IhDKkKlOGkQ62RMpSLoVvJfkUhmm31I5bGnfKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fgzDTrdS+dvEshZx/s0t9a1WWKep2aiZEkrohUzeBM=;
 b=UdkI6mPKR5STks54lQuqLy59h932SPG6fDb60tWC5fTwQS42Z8Y6VHxXRlzBd0roVT4NjOdVDzTKFEZesmhoAfwjCpRoG2EGTPNf51IekAfBp3Jr5mqNeEh4YDKFUVS0lveTcaGAgqJroNCzucjtd/eIJSluH1wMslsx/O6uLPs=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Sat, 25 Dec
 2021 22:53:33 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.022; Sat, 25 Dec 2021
 22:53:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Dorian Taylor (Lists)" <lists@doriantaylor.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSSAPI as it relates to NFS
Thread-Topic: GSSAPI as it relates to NFS
Thread-Index: AQHX+ExsNLi86uwBekq6KICGDicKsaxB5tIAgAAdtgCAAc9aAA==
Date:   Sat, 25 Dec 2021 22:53:33 +0000
Message-ID: <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
 <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
 <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
In-Reply-To: <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbde337b-9699-4ec2-2996-08d9c7f960d8
x-ms-traffictypediagnostic: CH0PR10MB4940:EE_
x-microsoft-antispam-prvs: <CH0PR10MB49409423723C3462CE6756BF93409@CH0PR10MB4940.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swepFvOgtFjK7CHYQwddzmnzu3sf7yQQib0bsS4Ii+HnPoED3BpyHELkQWmNVlO7nnD6+yVZw3p8EzQ1XDXdNWev+6+Da1M4Mp7RaKW9I6RuGF+l4HdnK3ROX5RbUj4ItzT9G3Ilr4AjVaQBAic4BZMw6osxEj+yy7jRSkmgd4bRtFBwNSLPhHXEEAX13DAsDhfRl6xUF+/9zFcW8ow8Pi20QRUsYpOucXXY/vXFYogqQ0CzZs3s2UvTZ48afI1bzfdjlIslfqGhzZTNtIOwyBdbV+JN/wu3VtoLnJkH8Dg0c8XbIoUpEsRpBxa0ibnwegHYDl7KHXKRc34TwtUZinRA77jZqDqdDqzUfuf/wkho29MEBWCpfyv/OE0EMuWa3vF2s3K4m1OUasT3uMc1IIqQKfC8DRXcablBNVYfNZg5g70FgbJSY9kHMumXImzPjUtMpOrKrZ6v1l0ua3pJlyKW4dHXNT+/HwRjxSf/DLGhjFJ4rxcd36Dck6CKL/uFyBCN6b/kO44leL9jbQgPbbKObqIO7Aa/w0BmDg1JMwQQP55dZp+VkBrlpFkV18aNDasx2iKYz0tTPXoi3WqViZEQiPsOWf6CN+8cwskY9nCvea2aR3ur6aL1l8epmRrdbFdb8nf4n+7JaBcIiX0GRrkqCPClMzWXV2N5KAWj+juc+TYwe0TDyU53FCwf41nBzvh8DtiOFIRUisB8BLLtSUMXTSTQTZtioP9Yb3Mps9RKIelBka9OV6EGxNmQ/m8q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66946007)(36756003)(6916009)(2616005)(186003)(26005)(71200400001)(64756008)(5660300002)(66556008)(66476007)(66446008)(316002)(76116006)(33656002)(4326008)(83380400001)(122000001)(38100700002)(8936002)(86362001)(8676002)(508600001)(6512007)(6506007)(53546011)(6486002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emtPaUN6Zm1aK2xqWDJDUUdnemxlOXhaQXlsL3IrMEsxelFldG9JSlhTSExu?=
 =?utf-8?B?b2hwaW1uQlFZcWYrdmdNeXBKUXpWYW4yK1d2Y21mQ3YwdVdJbTZ4VmxVWVdz?=
 =?utf-8?B?VVZidm9ZY1hLaGlkZVd1UkpBZFVoUTZtVE4vd0wzMldxZE5zemlWSXJJbGt1?=
 =?utf-8?B?UnpTbWVJZVdmMmZYdDF2NmtRWGYxWHNnclF0Z3d6bnNYRHgvQkkvblhLd3hO?=
 =?utf-8?B?eUg3QjBQaURndFc5MWlzZ09CR1BRWGlDR2lraVRkRTZoZllMRGFzRDJCNnVB?=
 =?utf-8?B?ckh2bkJGb0JSK29RSlJTcDY2amNTei9mdDlhZkRCWmp5VVdEV3V3OGxkdDkw?=
 =?utf-8?B?VVZyZzhONWhlbUQxZ0dVcms2RkdHL2F1VDk3TEVRZkpEdFB4cWw1a0FndHRZ?=
 =?utf-8?B?VndYNFRSa3hhcTRDWlFEak1CV0M4VUlPRlk4UyszaDYxQ000NHNGRk9yVDJv?=
 =?utf-8?B?NHFaZ0dKNzhDOXRWTDBkTTFFR0pJY0cvakM3S2xJTDIrTDhlY0h3TU5NckVt?=
 =?utf-8?B?Y0RueDNHZFlOcXhzV2JDajRLSmIyYWdCSjJrWEVhWmRFanRmZngzdFYrMk05?=
 =?utf-8?B?eGpxYVlaNnN2RlFNYUxkYk82b3M2UVNtVGowN3VFSW11cGZ6UzRHZUordW8y?=
 =?utf-8?B?TkJHTXNUU280WlJmdll5bHM4SlNtTmdTODBnWWNHdUtjK3lEVkZhWjZUS0o2?=
 =?utf-8?B?ZlcvZjBQM3UzMXNEK0QvZUpCc2tsV0FaU1FCdHo0SjFoK0twQ3V6TFhqbkNp?=
 =?utf-8?B?M3JEWDhKVXBocHdCUXNMekFqbi9RMFpiMXJnSWZaVDBhUnlOd0piSVY4V0k2?=
 =?utf-8?B?enNzWG9HN3JldDNmTVVrSzhHeDJvMTN1NldwcUlMdElRVkdIZmZrWU8vckta?=
 =?utf-8?B?c29kQURVZDk0UjFQbWVpRVhMR2VlM3BsQVNPZGNKdzgrMEdHclljU3Z2anRC?=
 =?utf-8?B?YU14RVgvQlF3RUNiZ2h3RGZEM2h2dHl4dXFkQmZ2Vk5ZcDdaSFlqSXVzeE1L?=
 =?utf-8?B?dEVjSjBCdXpaYXF2UEt2RG82b0tXSW1aYUcxNE5CdmUzRysrWUhoS1JBZy9r?=
 =?utf-8?B?dEpLdDRnMmFOazh0RDhrcENRak5jbGhFR1ZEclAvQmVSZmdmQ2gxaHJPWXcz?=
 =?utf-8?B?Z1dqUzBEcllWOVFBNFlFeUw4UkpZWlVPcnppT1BPVWQvTHd5c2JPNmRRQnZn?=
 =?utf-8?B?V2ZwWEVuWC9ONGprMURpZllpN3Q1Sk4wbXhIdjhkUkowYU5XVmRTV2xsQ1p1?=
 =?utf-8?B?Snp0djdPYjdVY3RKVitqMXJ1dEZjbHlIS3JrL1g2djZEUHJTT2JNQjFjV2tz?=
 =?utf-8?B?ZUdoc3RLV1N3UEtWR2FsOVJ2a1pScXVaOTRISDJqWGJxeFhrdGRTQzBRTmlM?=
 =?utf-8?B?MEh3OUl2bXQ4RjlkMkZaUk9hQUVzUmRIWnkvRmhIVDdVblI2TTh3czdFajds?=
 =?utf-8?B?TUNFQytJM3Y3UXU2NG5UY2pxZEN5VVh0em4vbGh5eDExZzNYS0F2dWExVGov?=
 =?utf-8?B?TXhxeis1U2gxdWsxVDZlQnRxVEdRcjJCdHhwSGUrVXB4KzRCcWw3RHN5WFFn?=
 =?utf-8?B?YkhCMlB1WFJtTUZmQXRVanRMY3VkN2hFTVRQbVl3OXdEWk5LUHJRQmtQNDFw?=
 =?utf-8?B?MGhxeUpwK3dCenlhb1EveXhmTFdmU3F2eTgyNW1XOWJGcE5nUVFETll0QlVV?=
 =?utf-8?B?L1NkOUlMK3JXVFZnMTdmd2FaZVBUSUZpUG9OeVlubmVhbTcwN1p4Um13OU5V?=
 =?utf-8?B?VGVjN3U4ZnNNSlNzdjl0ZHJWM0JLOVZTRUdJVHl1bklpVmloUkVCUFBDVVpu?=
 =?utf-8?B?TWxsK29oV3FhajgwbFcyTFRJeG1QS2F0UzhZM0tEL2hWdVFTSCtkZmxNZWlV?=
 =?utf-8?B?a3F4RXI3WWZNcDdMWHVqWndwRmg0YlE0eHdaaDJiTmxNV0l5VVNkZThjQ1kx?=
 =?utf-8?B?VURsRCtUWDgzeUpZenpHclFiczZ3VnlRcWFVSm9qLzRGWXJ6NElnOG1INFZ2?=
 =?utf-8?B?UW9jR0M2NUR6VTVxTXN0Y3FJZ1NmQzEzb3pwTmh5ZGY4NUtpMnFZNTBXK1U5?=
 =?utf-8?B?QnlQNWYzUjJQeUd3MXA2VHFNMUpwTC9vNStVMkpxcFVnR0c2M3BRbEg4ZVhI?=
 =?utf-8?B?cXQwWjQyc3VsblFaeVFaSlVucWxNdE9qS1dNY2dzZ3lSUDdzQkZMMnhta2Ur?=
 =?utf-8?Q?2HGszc64zAbGA0uMV2QPrAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9DC01CBCF7CC345A3CA1328FB46C6FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde337b-9699-4ec2-2996-08d9c7f960d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2021 22:53:33.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYo8E2kWm0l1uC4WbpGgsLwPOtzeOpxS54ZP5lrbvKREkv6D7chi85HcXVNXapVpLjo4LjqnsfvPR/ieV7/+7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10208 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112250117
X-Proofpoint-GUID: g9EKQuOtmuoOYIfgGpodxlqzrVUm8R-P
X-Proofpoint-ORIG-GUID: g9EKQuOtmuoOYIfgGpodxlqzrVUm8R-P
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRGVjIDI0LCAyMDIxLCBhdCAyOjE1IFBNLCBEb3JpYW4gVGF5bG9yIChMaXN0cykg
PGxpc3RzQGRvcmlhbnRheWxvci5jb20+IHdyb3RlOg0KPiANCj4gDQo+PiBPbiBEZWMgMjQsIDIw
MjEsIGF0IDEyOjI4IFBNLCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+
IHdyb3RlOg0KPj4gDQo+PiBtYW4gOCBycGMuZ3NzZA0KPj4gDQo+PiBUaGUgIi1uIiBvcHRpb24g
bWlnaHQgYmUgaGVscGZ1bC4NCj4gDQo+IEludGVyZXN0aW5nLCB0aGFua3MuIEkgdHJpZWQgaXQs
IGJ1dCBwcmVkaWN0YWJseSBpdCBjb21wbGFpbmVkIHRoYXQgbXkgY2NhY2hlIHdhcyAoY29ycmVj
dGx5KSBvd25lZCBieSB1aWQgMTAwMCwgbm90IDAuIFdoYXQgSeKAmW0gd29uZGVyaW5nIGFib3V0
IGlzIHdoeSB0aGUgdWlkIGluIHRoZSAkUlBDX1BJUEVGUy9uZnMvJENMSUVOVC9rcmI1IHBzZXVk
b2ZpbGUgaXMgMCB3aGVuIGl0IHNob3VsZCBiZSAxMDAwLiBMaWtlIEnigJltIHRyeWluZyB0byBk
ZXRlcm1pbmUgaWYgSSBoYXZlIHNvbWV0aGluZyBtaXNjb25maWd1cmVkIHZzIHdoZXRoZXIgc29t
ZXRoaW5nIGlzIGNhbGxpbmcgZ2V0ZXVpZCgpIHdoZW4gaXQgc2hvdWxkIGJlIGNhbGxpbmcgZ2V0
dWlkKCkgKG9yIHdoYXRldmVyKS4gUmVzdGF0aW5nIG15IHNpdHVhdGlvbjoNCj4gDQo+ICogSSBy
dW4gYGtpbml0YCBhcyBteXNlbGYgYW5kIGdldCBteSBUR1QNCj4gKiBJIHJ1biBgbW91bnQgLXQg
bmZzNCAtbyBzZWM9a3JiNXAgaG9zdDovbGlzdGVkL2luL2ZzdGFiL3dpdGgvdXNlci9mbGFnIC9k
ZXNpcmVkL3RhcmdldGANCj4gKiBJIGdldCBFUEVSTSB3aXRoIGFkZGl0aW9uYWwgaW5mb3JtYXRp
b24gc2F5aW5nIHRoZSBtb3VudCB3YXMgZGVuaWVkIGJ5IHRoZSBzZXJ2ZXIgKGFjdHVhbGx5IGEg
cmVkIGhlcnJpbmc7IHdpcmVzaGFyayBzaG93cyBub3RoaW5nIGNvaGVyZW50IG1ha2VzIGl0IHRv
IHRoZSBzZXJ2ZXIgc28gdGhlIHJlcXVlc3QgaXMgc3VtbWFyaWx5IGRlbmllZCkNCj4gKiBycGMu
Z3NzZCAtZiAtdnZ2IHNob3dzIHRoYXQgdGhlIGZhaWx1cmUgaXMgYmVjYXVzZSBpdCBjYW7igJl0
IGZpbmQgYSBrZXl0YWIgZm9yIHZhcmlvdXMgc2VydmljZSBwcmluY2lwYWxzDQo+ICogcHJvYmxl
bSBpcyBJIGFtIGV4cGVjdGluZyBpdCB0byB1c2UgKm15KiAqdXNlciogcHJpbmNpcGFsDQo+ICog
SSBrbm93IHRoZSBtb3VudCBzaG91bGQgd29yayBiZWNhdXNlIG15IE1hYyBpcyBhbHJlYWR5IGRv
aW5nIGl0OyBpdOKAmXMgdGhlIExpbnV4IGNsaWVudCB0aGF04oCZcyBmYWlsaW5nDQoNCklJUkMg
TGludXggcmVxdWlyZXMgdGhhdCBhIG1vdW50IG9wZXJhdGlvbiBiZSBkb25lIGJ5IHJvb3QuIElm
IHlvdSBydW4gZ3NzZCB3aXRoICItbiIsIGJlY29tZSByb290LCB0aGVuIGtpbml0IGFzIHlvdXJz
ZWxmLCBJIHRoaW5rIGl0IHNob3VsZCB3b3JrLg0KDQpUaGVyZSBoYXMgYmVlbiBzb21lIGRpc2N1
c3Npb24gYWJvdXQgZW5hYmxpbmcgYSBub24tcHJpdmlsZWdlZCB1c2VyIHRvIHBlcmZvcm0gYSBt
b3VudC4uLiBpdCdzIGEgYml0IHRyaWNreSBiZWNhdXNlIHRoZSBmdW5jdGlvbiBvZiBtb3VudCBp
cyB0byBhbHRlciB0aGUgZmlsZSBuYW1lc3BhY2UsIHdoaWNoIHRyYWRpdGlvbmFsbHkgcmVxdWly
ZXMgZXh0cmEgcHJpdmlsZWdlIHRvIGRvLg0KDQpNYWMgT1MgaGFzIGhhZCB0aGlzIGZ1bmN0aW9u
YWxpdHkgZm9yIGFnZXMgdG8gZW5hYmxlIGJhc2ljIEZpbmRlciBvcGVyYXRpb24uIExpbnV4IGRv
ZXNuJ3QgaGF2ZSBpdCB5ZXQuDQoNCg0KPiBJIGhhdmUgdHJhY2tlZCB0aGUgZmFpbHVyZSBkb3du
IGFzIGZhciBhcyB0aGUgcHNldWRvLWZpbGUgJFJQQ19QSVBFRlMvbmZzLyRDTElFTlQva3JiNSBj
b250YWluaW5nIGluY29ycmVjdCBpbmZvcm1hdGlvbiAobmFtZWx5IGl0IHNheXMg4oCcbWVjaD1r
cmI1IHVpZD0wIHNlcnZpY2U9KuKAnSB3aGVyZSBpdCBzaG91bGQgYmUgc2F5aW5nIOKAnG1lY2g9
a3JiNSB1aWQ9MTAwMOKAnSkuIElmIHRoYXQgcHNldWRvLWZpbGUgY29udGFpbmVkIHRoZSBjb3Jy
ZWN0IGluZm9ybWF0aW9uIHRoZW4gYnkgYWxsIGFjY291bnRzIHJwYy5nc3NkIHNob3VsZCBkbyB0
aGUgcmlnaHQgdGhpbmcuIFRoaW5nIGlzLCBJIGRvbuKAmXQga25vdyB3aGF0ICh0aGUga2VybmVs
PyBzb21ldGhpbmcgZWxzZT8pIHBvcHVsYXRlcyB0aGF0IHBzZXVkby1maWxlLCBhbmQgSSBoYXZl
IHplcm8gbGVhZHMgYXMgdG8gd2hhdCBjcmVhdGVzIGl0IHNob3J0IG9mIGV4aGF1c3RpdmVseSBw
b3Jpbmcgb3ZlciB0aGUga2VybmVsIGFuZCBuZnMtdXRpbHMgKGFuZCBvdGhlcj8pIHNvdXJjZSBj
b2RlLg0KPiANCj4gKEkgc2hvdWxkIGFsc28gbm90ZSB0aGF0IEkgaGF2ZSB0aGUgZGVidWcgb3V0
cHV0IG9uIHJwYy5pZG1hcGQgYWxzbyBjcmFua2VkIHVwLCBhbmQgaXQgZG9lcyByZXBvcnQgdGhh
dCBpdCBpbnRlcmFjdHMgd2l0aCB0aGF0IHJwY19waXBlZnMgcHNldWRvLWZpbGVzeXN0ZW0gYnV0
ICpub3QqIHRoYXQga3JiNSBwc2V1ZG8tZmlsZS4pDQo+IA0KPiAoSSBldmVuIHJhbiBtb3VudC5u
ZnM0IGluIGdkYiwgYnV0IHNpbmNlIGl04oCZcyBzdWlkIGFuZCBiZWNhdXNlIG9mIHRoYXQgSSBo
YXZlIHRvIHJ1biBnZGIgYXMgcm9vdCwgSeKAmW0gbmVjZXNzYXJpbHkgZ29pbmcgdG8gbWlzcyB0
aGUgZXhhY3QgdGhpbmcgSeKAmW0gbG9va2luZyBmb3IuKQ0KPiANCj4gSSBoYXZlIHR3byBoeXBv
dGhlc2VzOg0KPiANCj4gKiBJIGhhdmUgbWlzY29uZmlndXJlZCBzb21ldGhpbmcsIGJ1dCBpZiBJ
IGhhdmUsIEkgY2Fu4oCZdCBmaW5kIHRoZSBkb2N1bWVudGF0aW9uIG5lZWRlZCB0byB1bi1taXNj
b25maWd1cmUgaXQsIGJlY2F1c2Ugbm8gZG9jdW1lbnRhdGlvbiBJIGhhdmUgZm91bmQgc28gZmFy
IG1lbnRpb25zIHRyb3VibGVzaG9vdGluZyBuZnN2NCtnc3Mva3JiNSB3aXRoIHVzZXIgKG5vdCBt
YWNoaW5lKSBjcmVkZW50aWFscywgYXQgbGVhc3Qgd2l0aCBub24tcm9vdCB1c2VycyAoZGVzcGl0
ZSBhcHBlYXJpbmcgdG8gYmUgc3VwcG9ydGVkIGluIHRoZSBzb3VyY2UgY29kZSkNCj4gDQo+ICog
c29tZXRoaW5nIGlzIHNob3J0LWNpcmN1aXRpbmcgd2hhdGV2ZXIgbWVjaGFuaXNtIGlzIHN1cHBv
c2VkIHRvIGNvcnJlY3RseSByZXBvcnQgbXkgKHJlYWwpIHVpZCB0byB3aGF0ZXZlciBvdGhlciBt
ZWNoYW5pc20gbWFrZXMgaXQgc2hvdyB1cCBpbiB0aGF0IGtyYjUgcHNldWRvLWZpbGUgd2hpY2gg
c3Vic2VxdWVudGx5IGRpcmVjdHMgcnBjLmdzc2TigJlzIGJlaGF2aW91ciwgYW5kIHRoZXJlIGlz
buKAmXQgYSB0ZXN0IGNhc2UgdG8gY2F0Y2ggaXQuDQoNCkFGQUlLIHlvdSBhcmUgbm90IGRvaW5n
IGFueXRoaW5nIHdyb25nLiBJdCBqdXN0IGlzbid0IHN1cHBvcnRlZCBvbiBMaW51eCBhdCB0aGlz
IHRpbWUuDQoNCg0KPiBFaXRoZXIgd2F5LCBpZiB0aGVyZSBpcyBhIGZsb3cgZGlhZ3JhbSBraWNr
aW5nIGFyb3VuZCBzaG93aW5nIGFsbCBvZiB0aGUgcGFydHMgYW5kIHBpZWNlcyBvZiB0aGUgbmZz
djQra3JiNSBtb3VudGluZyBwcm9jZXNzLCBJIHdvdWxkIGJlIGV0ZXJuYWxseSBncmF0ZWZ1bCB0
byBzZWUgaXQuDQoNCkknbSBub3QgYXdhcmUgb2Ygc3VjaCBhIGRpYWdyYW0uDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg0K
