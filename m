Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59056611A83
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ1Sxe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1Sxd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:53:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AF23795B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:53:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SHbcJO030897;
        Fri, 28 Oct 2022 18:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x9RhjYmqa3UnMRR2gkFqPsftZ0cIetu1oOhwoqAsy5k=;
 b=040IYr3U+v/XNzerAcmSjwzxEdhSvpa+pu9fTD8Yps7kHTMZiY/q2EU5gwOvnFynbPsZ
 yu7GCkILcmVUUnvnpjLdg4sfiTgzkbPrPeMk7lrMY9O7wZjROQyQ8i9BUg5p2vprrWcU
 q0Sd2buSH7/eZLiAG2FrHzAnHuck29JoZFi4jiYj1AcZro5z15AgEDSQT9TGnBF7qcpF
 Lygv8LdoliZ2mrhwZQIt64JQTwtSxkEzumMq4h4FMRwrQejPVL5j6Vnw0tIR5AiXIcy9
 BU2XUjvkyhPTKqAgRGzGEVq6z4o23LZhTEk7TspmXNInx5ZLVlgELZHtt7gS3KrOu6fG iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays60hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 18:53:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SHVYYh032576;
        Fri, 28 Oct 2022 18:53:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagpchgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 18:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc6e5jv87FzXgjeyAKbfu41k6uFgrWBSqZmtq8/ER7O42KlMBCkif7AeuwnA749fajrqjU5XrWcYUcqBlOH9G9f9P6UrE9lNhiklgyma1dOmJpmAW44Mi34WBC47rbOKxihMluIFbfY6L60e+O3leUUgQ6AzfOYX7aqWGzJgeiVFEto3gjlfz4ILUKTYfy+PuJGR7921ZDp/5taFIZHyZpPdJa0cJDMfOzrgNhTOUcF07rTi4q7ooWfg8EEA8BEcM64UtEP/AWc3IwHZmaSiVv3zoIR/pbwiXvOu6F3bzWn1I5XR8ZwqAwihzHACNyl+LgRqTGaE/RbTd7eJ4zYCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9RhjYmqa3UnMRR2gkFqPsftZ0cIetu1oOhwoqAsy5k=;
 b=FaQxCPPeFqaWWwwAnOBWn4ku4/8G3Peh39jDIO+0B2NGlBcVCkK3lUtjxykHmW3/2jqUVz3M1J/ZxrdmOdn44snLNHpniJtI7izfz4+O0busGa5qahphuIOHXVNoX/lICKlYkU1c1Bpzwf1OCnGYthqd+Xnuq91Sdkkbv5SbGQEn4uXZMNBILcgp0V2S/hq2CvhY83vD3XSp/UsZpyRUAfAM2sP9XXPICLteBWhAN5qX5CjLHX1qu1guDDnEGEfH1VjnqMflAM9qQGogHLxcDe/1CDHT3hv0y2KBmuf3N7g+4Y7dWmf3T5srBdtbE3TnzYtBBWyPwQzO2HDj7tNbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9RhjYmqa3UnMRR2gkFqPsftZ0cIetu1oOhwoqAsy5k=;
 b=ShpG/yJKedKJ0Q5oRJhjgFwXg0MxNLkMbNXbNmjqzn1cd9tiDEgGya4GFosyQTyuSZwYgHNe+TI/fjuTk4+stJ2GOrQndMv6iGUhjm1gtbBSg97+7zdlQoMlYINaS88ndBBYH3ltqJzQPDnIRKnT5MgQX0Og4o4+4+09YTB4d3Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 18:53:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 18:53:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Topic: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Index: AQHY6k5k3iaHcLvdwUOL1QTSt6QmjK4jykqAgAAebwCAAAbTAIAABgIAgAAZQACAAAYeAIAAE48A
Date:   Fri, 28 Oct 2022 18:53:21 +0000
Message-ID: <2D64526B-6270-49B9-AC2C-F0118DCF2AF9@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
 <20221027215213.138304-4-jlayton@kernel.org>
 <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
 <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
 <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
 <cc4bfa448efedd0017fc7b20b8b7475907acbc5e.camel@kernel.org>
 <A040CDCA-5E3F-470F-8D69-8FF9DA4325FE@oracle.com>
 <098163d8067962f84a06af5d03379e2157974625.camel@kernel.org>
In-Reply-To: <098163d8067962f84a06af5d03379e2157974625.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5737:EE_
x-ms-office365-filtering-correlation-id: a96aeb18-38b4-4926-218a-08dab915af96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rCVv0j1Md8Wuv2Cj5fVSPD0rg+RQdfKNNHdbasLufXX8XFu3Tnlt1q0lK3+Fp3+tLqG3YPSonIrWTMN0eQWB6JNYCs0PIQmZ+vgrf8x6bbxiwxlBjCUT8nLL4zGVpTb1iNo1UopwaB4D7v8ozaHfg2I4lOyztpOgF3Fc4LbAKDB1inQZw85pzJmiJcCRx2w8BOURUyqtYpRPakVnbaSKA1588swLLNh7YfMMMVeoqVxTGnIM21jszCfUxeBi07w3WD3nUPvMiGZfITmvfBZ9rEgV0HDzdgY0YKhyag9VoLHNFS2AoiHlUAWWpofIvHECaibsZAT/B5pTk0PCheYiOwJmtBJI2Tjurj4fRh5ZkfuHnlTCuwUxuFxAu3TlbY09rSs4cakpdFDlm9C7KVy626jN8LA7mY5bCnpiviw5a8yBajxw5d26aSlI34694oVhs/O+hRp+qDGwkp0GTH/BkB2mW/wUbrg4oa/xIzXzv661SEBo0ACeuynQ8Gtl7HJKWQ4cToACXPYK76xuHj4gRxaoTLmu1YdQ8paImjL97gWCghyXDBl3bTMq1+xWJ6NOnVcpKiI5yH4W2gTb2aggD8k0jDYcT9ikhai3a8iSCLG8NPd6rTKShiXO2M9Q+mTkXHGn8KUK1viPcjIqVe7gl74TdwkdiDokNK/ca7VM3VdSgQtlxyE+0rUfO/HTpeyw16CH9omOFpD+5nuaxMI/GyZ7KBsXt76XYH7WKEcT91gcXVGg4zsa+y9ui4N5IclIdJpkQ76H+VPNNB4OeryZOHJZ6510EtpEiwdwOUMVMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(6916009)(6512007)(122000001)(478600001)(38100700002)(66899015)(38070700005)(6486002)(316002)(5660300002)(71200400001)(54906003)(26005)(4001150100001)(91956017)(4326008)(76116006)(41300700001)(8676002)(66446008)(86362001)(83380400001)(53546011)(186003)(66556008)(33656002)(36756003)(2616005)(2906002)(8936002)(66946007)(64756008)(6506007)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?76jJG84QFi9Y4SlD0vcAhZTsCE4bL9yCJI/F2oYMANioUnsDtrNvEl8zw6wf?=
 =?us-ascii?Q?KWeUv06d1fLfLcdNWcKLbR35IKv8sM91xTC7ezQMlupCWmoYkvKwKEicqWjp?=
 =?us-ascii?Q?/ljA393wWyJVdSk/GsEmOC0SF9t0PRyiUlCIdImeSLndrJffPUckNo8u/HHh?=
 =?us-ascii?Q?mxa6sVjshVdDenV6wmP1GTh0c6XvQhHpVMTRVMxNjmb0u/cT1yylJIyNpfVS?=
 =?us-ascii?Q?a8E1FfwLR8Yo9rQfqLWe+P1X01PpmZalmHP3f6vX7WC9dxVvz04YRXn0FY2r?=
 =?us-ascii?Q?Kqhf2nbG0tK8wc0pwuS+PnTTxC81GWaRAAKjqHcQ1KeQ2ciz6SKTaa7WUbQK?=
 =?us-ascii?Q?V9dkvtvZ81oymJxGUhrB2UZIFdigdpyKvLarWApWcyniv4wqNfOB+0wVBU3Z?=
 =?us-ascii?Q?+uzWIOHp9w5HQj0sE8gqlPJFVubBCEnrlrswZbh2dFx5negAFiNCvq3GDSrF?=
 =?us-ascii?Q?SLpyttKWfHfrfRRkDhx0MAxBf8Pd8t21m1msnLb3/4JkYAfqBCqV7paQ7wPs?=
 =?us-ascii?Q?qmqPywpjXTT4+zlUKABS+KLqGFqh1b2NxhW3FdtmvibLioHO5C4jLA27DgqZ?=
 =?us-ascii?Q?dP52TnU5+viCA0tf9Lfk5dTrM4uhlMkmWIf4vL9Lgwy+eOHObuWYXlmxfcIp?=
 =?us-ascii?Q?VBlNlb2T1MKHVoW8lRVJ9Mhi6ogZqpE/HpsArh59KtVzQVN/UtBI4Nm9mZ0u?=
 =?us-ascii?Q?E1iCnFRYEV6xll4ixSHVAseLp/YChpSYYCPXFV5OsGd9aC+gPq2RnlW/REHU?=
 =?us-ascii?Q?iTUAEQvoeBGFKt6zBQW0VrwAT8ucV5izYFyxq9k0AEMkK+FSVOdd3l9K/woN?=
 =?us-ascii?Q?1sGqv/wJJf/187iBhcsDhcXvGuiZCmSk7nAyni0LaYwOqnSmIwIZWnRENGCO?=
 =?us-ascii?Q?7tt5RX98qcX7cG3NcQcMBi0Ysc9ip6pT+QCn39ogAHlIpp9W4Jvl7Rb3tNZ1?=
 =?us-ascii?Q?KJGdBxG03R4aRbR9lZMwGJyYyCm9HbLjUxSg7G+c0pfChsGgd4SmtZArbc9j?=
 =?us-ascii?Q?zRYihXvlQf7EQ3yPpgv5GlbgMZaDS4KvMS4jRC89KBMEdmqhYORNJqb6KjHv?=
 =?us-ascii?Q?I5CHejmugwceOTRpXh1CSwfKDk8tNpi29rUK/742DCecz/NFkf9SyzPP04Ij?=
 =?us-ascii?Q?JN/CZkZpp2zugCrPzyuzcLQDatZH0+xl0nDKwJLjcQY5fkfw4MqO6toKP4N9?=
 =?us-ascii?Q?Gu9pDG4NcgVtMe+RUyq+z/JAliAbu3UbVIS4Wr+UoBiUN8Ur9h26+1540+Df?=
 =?us-ascii?Q?bEPiz02tKRFon5CqwN1ecVhW/2/NlbNC2tFIsuaVqD8HSoZ8bK4PlxR+FXXb?=
 =?us-ascii?Q?qsSa7Kn6MKyKg+IeduSGeG7V4m/XD+x4EEdMH9XDcP3mG8u+vsrn22ibB7cv?=
 =?us-ascii?Q?fRvTso5IMtmiYfWw9G1/uh/BWLO22OgXuAKrcdWWUZAlT6aQKgsLJLbeWaSu?=
 =?us-ascii?Q?22Z8RNLJZnUu8rLfhF8tGn+CHpsnLe4Fe8LWwMC3oIGBXM5Yo/0kIgj+Yges?=
 =?us-ascii?Q?XCITh5PULQ4hoA4FS1g77kZMQYKFMY1x25qz6eMKiTViqRTMYwgQDzhCukhY?=
 =?us-ascii?Q?370MtmjY+4p5EhhOZ8xWtfXiQjGsxXLFxhLXT1apEeoYl0SHphaY25UkZI2s?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C31761E38F8CF94EAFC68639DBDFDE35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96aeb18-38b4-4926-218a-08dab915af96
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 18:53:21.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5kVqANjLjTfLSSQTTrSfxYaCBWwWHTrrqDyO2FIRVnhq1X1NVUj1NsrCGLXARm5EhJzG9Cb/x2qxK+YQMTMuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280119
X-Proofpoint-ORIG-GUID: -EPgI6t0djY0shP979r5IVzPOHJlJbce
X-Proofpoint-GUID: -EPgI6t0djY0shP979r5IVzPOHJlJbce
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 1:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-10-28 at 17:21 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 28, 2022, at 11:51 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2022-10-28 at 15:29 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Oct 28, 2022, at 11:05 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> The problem with not calling vfs_fsync is that we might miss writebac=
k
>>>>> errors. The nfsd_file could get reaped before a v3 COMMIT ever comes =
in.
>>>>> nfsd would eventually reopen the file but it could miss seeing the er=
ror
>>>>> if it got opened locally in the interim.
>>>>=20
>>>> That helps. So we're surfacing writeback errors for local writers?
>>>>=20
>>>=20
>>> Well for non-v3 writers anyway. I suppose you could hit the same
>>> scenario with a mixed v3 and v4 workload if you were unlucky enough, or
>>> mixed v3 and ksmbd workload, etc...
>>>=20
>>>> I guess I would like this flushing to interfere as little as possible
>>>> with the server's happy zone, since it's not something clients need to
>>>> wait for, and an error is exceptionally rare.
>>>>=20
>>>> But also, we can't let writeback errors hold onto a bunch of memory
>>>> indefinitely. How much nfsd_file and page cache memory might be be
>>>> pinned by a writeback error, and for how long?
>>>>=20
>>>=20
>>> You mean if we were to stop trying to fsync out when closing? We don't
>>> keep files in the cache indefinitely, even if they have writeback
>>> errors.
>>>=20
>>> In general, the kernel attempts to write things out, and if it fails it
>>> sets a writeback error in the mapping and marks the pages clean. So if
>>> we're talking about files that are no longer being used (since they're
>>> being GC'ed), we only block reaping them for as long as writeback is in
>>> progress.
>>>=20
>>> Once writeback ends and it's eligible for reaping, we'll call vfs_fsync
>>> a final time, grab the error and reset the write verifier when it's
>>> non-zero.
>>>=20
>>> If we stop doing fsyncs, then that model sort of breaks down. I'm not
>>> clear on what you'd like to do instead.
>>=20
>> I'm not clear either. I think I just have some hand-wavy requirements.
>>=20
>> I think keeping the flushes in the nfsd threads and away from single-
>> threaded garbage collection makes sense. Keep I/O in nfsd context, not
>> in the filecache garbage collector. I'm not sure that's guaranteed
>> if the garbage collection thread does an nfsd_file_put() that flushes.
>>=20
>=20
> The garbage collector doesn't call nfsd_file_put directly, though it
> will call nfsd_file_free, which now does a vfs_fsync.

OK, thought I saw some email fly by that suggested using nfsd_file_put
in the garbage collector. But... the vfs_fsync you mention can possibly
trigger I/O and wait for it (it's not the SYNC_NONE flush) in the GC
thread. Rare, but I'd rather not have even that possibility if we can
avoid it.


>> But, back to the topic of this patch: my own experiments with background
>> syncing showed that it introduces significant overhead and it wasn't
>> really worth the trouble. Basically, on intensive workloads, the garbage
>> collector must not stall or live-lock because it's walking through
>> millions of pages trying to figure out which ones are dirty.
>>=20
>=20
> If this is what you want, then kicking off SYNC_NONE writeback when we
> put it on the LRU is the right thing to do.
>=20
> We want to ensure that when the thing is reaped from the LRU, that the
> final vfs_fsync has to write nothing back. The penultimate put that adds
> it to the LRU is almost certainly going to come in the context of an
> nfsd thread, so kicking off background writeback at that point seems
> reasonable.

IIUC the opposing idea is to do a synchronous writeback in nfsd_file_put
and then nothing in nfsd_file_free. Why isn't that adequate to achieve
the same result ?

Thinking aloud:

- Suppose a client does some UNSTABLE NFSv3 WRITEs to a file
- The client then waits long enough for the nfsd_file to get aged out
  of the filecache
- A local writer on the server triggers a writeback error on the file
- The error is cleared by other activity
- The client sends a COMMIT

Wouldn't the server miss the chance to bump its write verifier in that
case?


> Only files that aren't touched again get reaped off the LRU eventually,
> so there should be no danger of nfsd redirtying it again.

At the risk of rat-holing... IIUC the only case we should care about
is if there are outstanding NFSv3 WRITEs that haven't been COMMITed.
Seems like NFSv3-specific code, and not the filecache, should deal
with that case, and leave nfsd_file_put/free out of it...? Again, no
clear idea how it would, but just thinking about the layering here.


> By the time we
> get to reaping it, everything should be written back and the inode will
> be ready to close with little delay.



--
Chuck Lever



