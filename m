Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B057517B1E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 May 2022 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiECAGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 20:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiECAEV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 20:04:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC431B
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 17:00:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242NVcdt026132;
        Tue, 3 May 2022 00:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lsdtz+q3f6j0Sk4erBvoRCedFVXzgkS7JBFP0CGBWrw=;
 b=fTcuYKm1ZuTQV9W3Cxzjh8yV+NDvTKlCIOtabNGWx4nXxEl+Ysu3DHUZ231TkUmzf9lX
 fAkx/D6q0/V/sAt1739BelWL5VauWy9vuvgqJCCBDxrTFp8bmh4ZJ4YAjKIKP54G8+me
 oSiDGdfjuDO74HVhQ//TUkFTUukOgnibcYWezvEdJvSB6ioisW27sBW/SNDq3koZwhGs
 X/KyP52NGg5cxtAXcCK5SFFCTtDiJOh67/zsdEVNMRlGcv4p/0WVx+x9gfmLF/I3xoZF
 XUmpGfh8Q7gBi5Uv2L7sQJPfH/00kxo9QDMyQLgpk9nuVV6Sl3zpwLSOQ5gqT9qGwgto Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc4jg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:00:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242NooIv035442;
        Tue, 3 May 2022 00:00:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83441-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBenH7zg7AU8pi8VAxCl9uYqRNjvVlmfDmby0NKqUxKtsHYO3nMa4iddC+hiVrxTUjz2RN33D34kZdKq6PXnFVzspMj5pMhJNYwmcAPCRVguGUMCPcJfOImUN3KfVdzNLyUJ/9CuNW8lQViZII9zxoxXTXoXgxrzTTl/i5NnnVL+g2D7X0vm3He/XcDjUibnr2nlRdGOBQybOW8izN+B0GqqE4kwwyhb2xqAb8hlIP0G87w9/hqvz9rkNAvXcqKT+Fd5tX0b1pxEnQRPCbqrnu8Q4fBaenVVwi8zrcCOtKvX9fQgygDnhLmQgsgYRMxSZOI7h50F6lhslKg8nt2aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsdtz+q3f6j0Sk4erBvoRCedFVXzgkS7JBFP0CGBWrw=;
 b=R82XqQXZuki7aCLzjpaTWiEjJx0GPKzGl6ZS+68LHs7o6o24DBDT61ADr6m2quKpaMNu/VFUR9yeQbmfoDohfgSjbPZ7PQpR/lQzZX887rsBGGjGj/DnkbQyXDK/J0ap/Ib9FGQP4wKipVj8Tba2M1JapHeSyoWQDHnCYEZb97RaZ+oRCLsCFhEw84k7BvYVAMoxvPnXn5GEYRpzLlIXdrf499bwEaN9RCEA5Sdzoe1kOpvo/jl049e16giD3z5jFObK5Wz2nvyAnLyLLijkXPcoXl/ngD3+xjPV0S5znakehsvBXldAewnKjicXRZeFmLGSXIiVzO2nS+OVxR4PrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsdtz+q3f6j0Sk4erBvoRCedFVXzgkS7JBFP0CGBWrw=;
 b=goe0Dlf751Q4S0RNiiCDDJVk6p/A3UEMfwYyaxDozNCPgqrOGmLqwWucTeS7RxJxBLmt6yXuLxq8cIRs3fAat2zOWb2HlA5mSK9hbhvMwt4t1X07E6MS5OjgSuEM8KkX4q7Y5RoJq1b0lgUwPZsOf30Uh/vAOoE5C8HcsvjaObA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4804.namprd10.prod.outlook.com (2603:10b6:303:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 00:00:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Tue, 3 May 2022
 00:00:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Bruce Fields <bfields@fieldses.org>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "david.oberhollenzer@sigma-star.at" 
        <david.oberhollenzer@sigma-star.at>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>
Subject: Re: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Thread-Topic: [PATCH 0/5] nfs-utils: Improving NFS re-exports
Thread-Index: AQHYXgHepSBKAjcbhkm6tcc78z/taq0LxCaAgABs5oCAABR8AA==
Date:   Tue, 3 May 2022 00:00:19 +0000
Message-ID: <E9635F9A-390B-4B26-8BD2-9D05180421CC@oracle.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502161713.GI30550@fieldses.org>
 <929b0a83-7a10-8a26-941f-3819c957ba7a@redhat.com>
In-Reply-To: <929b0a83-7a10-8a26-941f-3819c957ba7a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07c195cb-d0e0-4c7b-2f55-08da2c97e997
x-ms-traffictypediagnostic: CO1PR10MB4804:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4804B421B44C36B7BE327C6A93C09@CO1PR10MB4804.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVl6B60KVqJHzDqfNQ7axRRRL7TV2YRjGEdHi2WavcKWb5f0qfamM2OJzpXEIw5d0Ks4eXCfUP3z2QN4pmNZG1bEviKGswOSocNvwNjdJH8wGzXs4Xt0T0FlXWY/cRN5qkbaT/6FNWphIWPl1axBuX7TaQRkGWX5FUot1fo3KlQklkvcQlhcLXmjVB9jLafHlvexKXB7zHizhaTlCdV2mfB2/eV0jjs2BegcJWUq4wj8aFV2W6ccVIMKDmPcGpZdn/prTZZ9K0Ro8CF1M99g46EzmlZW5J2k5oFdYh7totbyOYtG7/JCKJsCOWYYnhFoX/p4ofBjHTkHR2yooukegROBqpQGmofzoqAkWK6MAPeVW5OiyflZXdRyI/6z4ooYZKPQDBrlyMbYN3p06sW4GVTTmiq8qxnkU1v8AA7BaBF43EF2Gkyn36ZRhhDRoSWnmGH5gNC3+5xUzQQ1emwegdv32LSnwt2JnLzPzrtr4DvoAG4SOkBQwGPcOBU2GQ1S8Pmc61KH/nazDqURzEK87l0UsJIDn408Rh5YmpNCgj2M7V/F265YflvP93dZVJ8EQ9a3iZYWD1zRaXi98vdDxVBvPvZk8pDHq7RZ9aVHZN7y6EoSUT9+rWq401oAqWJgOA1MJuCSkzb3YbCKs0M2Vi1fUyTAzk6NaJ/D5HgVU6niFlkIoy6cfTgtDJyk4T/9hlHuNxzXYFlyyGUPME25hbkybWpHIym+e+wsLKBZAQT1QwiVM0ehz7Ml4NAuxl+gp4zSJAhec+8JBl3i19akukNLb4Fy9acP1vxS9wcU5fGRr0hfSF25P0RAj2nbZQq6JjIUANq/Ifa5bdMSf/PDDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(53546011)(122000001)(186003)(6916009)(54906003)(38100700002)(7416002)(38070700005)(6506007)(5660300002)(316002)(91956017)(33656002)(64756008)(66946007)(83380400001)(8676002)(76116006)(66476007)(8936002)(66556008)(66446008)(4326008)(71200400001)(86362001)(2906002)(508600001)(2616005)(6486002)(966005)(26005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vOX+jKyUNWzwp7FjnIPTDMtGQTZ0Y9KLwsrVQQp+xCD8iSuI60O+FoygpRpO?=
 =?us-ascii?Q?9XorvcCgAVwVa2c63Khv5lUEGSoDnu6xUVVN2Oe08eFfZ63+xr8lOxSE3uRw?=
 =?us-ascii?Q?AqbvoFFL5NN8vv71EWh3BphyzNYVEidsdR+Ip+asec6h6snosiWj6sfrCxyF?=
 =?us-ascii?Q?LORMwWKOod9GFEehzGKTYcPHrEunz1nUfKi/FnpwRKLpSDk1k4rDnTHc1lch?=
 =?us-ascii?Q?I/O9tp7g6L4MUp6f3TsPsGsmVYmsfn16+c8w3q1rGVHe7Lm43VxM6w04RBvs?=
 =?us-ascii?Q?GbzZiQeiOQdatsnuowC/aun5W8vhsdhtJYghdlE0GqG9bugLM1xT059gnUbE?=
 =?us-ascii?Q?qj1PCmHrQWD+yz6mmGucj+DHdU25/jEmUEPgHMoQUUfPyi3upDtFlTu7a/xj?=
 =?us-ascii?Q?CIjkwduTeb28M1tnhhk3T/lbQQkcTkrqU2fNlnwJ2ibloARu7SU6KrKEuG13?=
 =?us-ascii?Q?TZhr/lRiRC41WLjtVudXpcugGu5OaczV/tI0QAKaP+nUe7mpCs85afioPmMR?=
 =?us-ascii?Q?kQ5vmjNMWpkK8T1lbc60SxnHNdZjZ68mNgNNaxmMWOwLwYHqxGUaPFjCeT6S?=
 =?us-ascii?Q?g8kQW4q0wAuYZoGBbhYm0HeAqGtPaPt/GNexumQJOyHnhUkTjkiiAKzyVQz2?=
 =?us-ascii?Q?yxicTG3VUdeZBW8v0WpLc23WBeziEeB/tB4X6VfTFL1O24p732aWfvTenwER?=
 =?us-ascii?Q?5aTdCu+bl0JOABfJXHBZPaICOU//FvGwRfp53eFl2RopZ3UoOTe6oFQKEVul?=
 =?us-ascii?Q?9dYMvhFGCwE87YYR2c9G7qIJsQmucu2wFCLoxF76CT3ZsKnDMJzly4BQMsra?=
 =?us-ascii?Q?HJF05/iRF480ZpDkc21+dXH+LUtSrWrGymNbYgAGurKrPy0pzcSdRWy4lqUT?=
 =?us-ascii?Q?lhyZObjH6nw1rK62C1OUXVZPcS0qj9yDo23PZZw5+XUNSrhnMWoC8M0E9KYn?=
 =?us-ascii?Q?Z6f+EFObuINcFW3QbiecoNhZPvnK7GHGnOMy0WTkXgRsIAbMYnlKlvPW5kUU?=
 =?us-ascii?Q?SKK5HvBjw96gAHvlofITE6+Sc3Aex2NdliUuh5xauce+m/3WSQizGJCZJ9DD?=
 =?us-ascii?Q?ofF2SyPBNiouCN7Yrtuw4Ypr7QK23oFGNJ+VUFQ0LYa6ZN4vzpIIMLdaxn8c?=
 =?us-ascii?Q?CLjvh43/A2vb7sWHUZrPVi1KufODQbXEotgFp+cv9gvmHeAExkP30zZVlRA8?=
 =?us-ascii?Q?t8359VUJdirJkuYIy8xV5yRBeJJu8XiYPtE2CpRpebNoV5cZvc7lKBivByXg?=
 =?us-ascii?Q?zGgU1IJ6IqgIgnKMTO37vvWGa1tO5QlACBVc6mwEcgul9/JqzNdahfftICRh?=
 =?us-ascii?Q?bLxEFPpyPxxpMRxEnNurLRe3YgvesR9z1R0JqkvHJpGRXpTrHYT/Ph+bFpJ9?=
 =?us-ascii?Q?IN6nt7JwPXkJbnK5IGzaH1wlDExw7CQIbv3PJ7Y9GFGXgROqoDaw1oTNTatP?=
 =?us-ascii?Q?HidDnRa6SqvQsG7GifEbL+uN6vViQV/z1Cr9jhos0MxgCDsF21tTKIwoYuVf?=
 =?us-ascii?Q?9sQ3M4Yq7BAnz+PqWpnherDi6SADksXnFcwZSoiQaZYU0cebCPtH2tB8X+qo?=
 =?us-ascii?Q?KhkwZddb7o1yFEKl6uYtPUQKTBsvBfAVIeedkvan1esA3qnw9Bi4YK2UN+zE?=
 =?us-ascii?Q?xqCHvJ5DofhYroD96FfrkFtw+eywIKuiccc5eltp4EL3u90FpO6iE+s88lN0?=
 =?us-ascii?Q?aOv4/FXKcsJQwcLi2TwgzhS1FKpYwy5yn9hPWOyTijMt04Ec8DmFDQlgn7Dm?=
 =?us-ascii?Q?ZhljPb/iuaROqIc3/lU6/L95ooyPC2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BAF0DD76971BA48AE730B7F664D2EE8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c195cb-d0e0-4c7b-2f55-08da2c97e997
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 00:00:19.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tz/tK6FJ2oLNzk2AYGhsSd5QWrzYq8Yp63F4hlzgxNXCOhV5dwAogqLMPFdMqDsET4OWRR1xGq2rES+g86CS7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_08:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020173
X-Proofpoint-GUID: PKILSSezeN6cZt1jZpsbU1dx6WjMvSYQ
X-Proofpoint-ORIG-GUID: PKILSSezeN6cZt1jZpsbU1dx6WjMvSYQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 2, 2022, at 6:46 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
>=20
>=20
> On 5/2/22 12:17 PM, J. Bruce Fields wrote:
>> On Mon, May 02, 2022 at 10:50:40AM +0200, Richard Weinberger wrote:
>>> This is the first non-RFC iteration of the NFS re-export
>>> improvement series for nfs-utils.
>>> While the kernel side[0] didn't change at all and is still small,
>>> the userspace side saw much more changes.
>>>=20
>>> The core idea is adding new export option: reeport=3D
>>> Using reexport=3D it is possible to mark an export entry in the exports
>>> file explicitly as NFS re-export and select a strategy how unique
>>> identifiers should be provided.
>>> Currently two strategies are supported, "auto-fsidnum" and
>>> "predefined-fsidnum", both use a SQLite database as backend to keep
>>> track of generated ids.
>>> For a more detailed description see patch "exports: Implement new expor=
t option reexport=3D".
>>> I choose SQLite because nfs-utils already uses it and using SQL ids can=
 nicely
>>> generated and maintained. It will also scale for large setups where the=
 amount
>>> of subvolumes is high.
>>>=20
>>> Beside of id generation this series also addresses the reboot problem.
>>> If the re-exporting NFS server reboots, uncovered NFS subvolumes are no=
t yet
>>> mounted and file handles become stale.
>>> Now mountd/exportd keeps track of uncovered subvolumes and makes sure t=
hey get
>>> uncovered while nfsd starts.
>>>=20
>>> The whole set of features is currently opt-in via --enable-reexport.
>> Can we remove that option before upstreaming?

Somehow I missed Bruce's comment, but I had the same thought.
The cover letter does not explain why someone would want to
build nfs-utils without re-export support. If there isn't a
good reason for needing this switch, IMO it can be removed.


>> For testing purposes it may makes sense to be able to turn the new code
>> on and off quickly.  But for something we're really going to support,
>> it's just another hurdle for users to jump through, and another case we
>> probably won't remember to test.  The export options themselves should
>> be enough configuration.
>> Anyway, basically sounds reasonable to me.  I'll try to give it a proper
>> review sometime, feel free to bug me if I don't get to it in a week or
>> so.
> How about --disable-reexport? So it is on by default to help testing
> but if there are issues we can turn it off...
>=20
> steved.
>=20
>> --b.
>>> I'm also not sure about the rearrangement of the reexport code,
>>> currently it is a helper library.
>>>=20
>>> A typical export entry on a re-exporting server looks like:
>>> 	/nfs *(rw,no_root_squash,no_subtree_check,crossmnt,reexport=3Dauto-fsi=
dnum)
>>> reexport=3Dauto-fsidnum will automatically assign an fsid=3D to /nfs an=
d all
>>> uncovered subvolumes.
>>>=20
>>> Richard Weinberger (5):
>>>   Implement reexport helper library
>>>   exports: Implement new export option reexport=3D
>>>   export: Implement logic behind reexport=3D
>>>   export: Avoid fsid=3D conflicts
>>>   reexport: Make state database location configurable
>>>=20
>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=
=3Dnfs_reexport_clean
>>>=20
>>>  configure.ac                   |  12 ++
>>>  nfs.conf                       |   3 +
>>>  support/Makefile.am            |   4 +
>>>  support/export/Makefile.am     |   2 +
>>>  support/export/cache.c         |  71 ++++++-
>>>  support/export/export.c        |  27 ++-
>>>  support/include/nfslib.h       |   1 +
>>>  support/nfs/Makefile.am        |   1 +
>>>  support/nfs/exports.c          |  68 +++++++
>>>  support/reexport/Makefile.am   |   6 +
>>>  support/reexport/reexport.c    | 354 +++++++++++++++++++++++++++++++++
>>>  support/reexport/reexport.h    |  39 ++++
>>>  systemd/Makefile.am            |   4 +
>>>  systemd/nfs-server-generator.c |  14 +-
>>>  systemd/nfs.conf.man           |   6 +
>>>  utils/exportd/Makefile.am      |   8 +-
>>>  utils/exportd/exportd.c        |   5 +
>>>  utils/exportfs/Makefile.am     |   6 +
>>>  utils/exportfs/exportfs.c      |  21 +-
>>>  utils/exportfs/exports.man     |  31 +++
>>>  utils/mount/Makefile.am        |   7 +
>>>  utils/mountd/Makefile.am       |   6 +
>>>  utils/mountd/mountd.c          |   1 +
>>>  utils/mountd/svc_run.c         |   6 +
>>>  24 files changed, 690 insertions(+), 13 deletions(-)
>>>  create mode 100644 support/reexport/Makefile.am
>>>  create mode 100644 support/reexport/reexport.c
>>>  create mode 100644 support/reexport/reexport.h
>>>=20
>>> --=20
>>> 2.31.1
>=20

--
Chuck Lever



