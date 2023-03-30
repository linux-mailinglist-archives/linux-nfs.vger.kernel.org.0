Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A66D0C04
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjC3Q6E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3Q6D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 12:58:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE92469A
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 09:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N03aSBIuQqSjl8MZVT9DQy1J2ReyAdxI11xIavLsSCccRA94sYNLDsRqkWY/dgHw/Of/yrezmRlQVGnvXsWSeUvM2OQwLfzTZlJ561h+JQZClFc+8b97DXy6KHYYaSybqeoxXLP8DvS9k1KHlbT7GBJ+TVKHCiWlh8E5hUU44WrvKDbftSSljSYXXbbmsTr/e0Vie9p3hZHHCByOa15Z6hsJWK/Ckwj6/SSYkbUpon3/cHqHvoPB+MhZ7LeEB8YVU70VQFKy3kakJeCxtCQ6hh2UZYipm//1a30tCBDmI5AVoefRs5vnne2djQ7YjuEoU2IcIo6nfD0u4nFYO43GCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBWKh6TK7Ah+rpClv6RN76s8ynyd0fyfEvGT610S9dk=;
 b=KXz/UWEf+zB0O9tUyTXfC+IiuuCk2uw3Wf92X2MnR6dDm82N0A60HL/HBprqjZ+ZXLp6NtlMUEqeo0SVSPaOeNrJsS7Rlzz/RzG5VPU6uCCeEq30FNslR6nIXEOUQlQnGUlwVRA4cikHOmLo/3L8YHqBtApeoFs970JefzMSrE3dgfnXQX9sVA/Js8fVECrmECQc9qlWRtqeRLm6vzcyWF5QzgWI6/nBKT3w3jIWm3FJKp1ieUUNY0Sa4Ipq2a4fmgXgA69klGYJtRHkalsoTAblUTXpcmr6WHyynwKov1A6UA0ez+Ofk286NNdS1r83QK+zipwIEX7e5JY765kcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBWKh6TK7Ah+rpClv6RN76s8ynyd0fyfEvGT610S9dk=;
 b=QmrNV+Y6gmMknisdYjaie4gJ/w43svid4AQUFFyzqLY9IZ2hi/MLad6lpmOYnE/RHRJhDBo61Rr5vfLDEvi1i+gxtB2hRHEjv2fT1jGQ/exbo+ivSA7iiWDD0KyzFYqiRwIQWi+iXDIahvkUIVENVg3L+yJPFNeEmNVVzt8lIIO8Z2qhfnqT5D7GLlI7UCJUxbWaZajkmqsG5WLmzFBNn8IHZW95EzV4p8txR43rri7nFHFZy5i3PXJ93pI3J8GJjgOz6HnyrHV4IZbknb45QFAcS4oXIum/K84syROvZrXOuBukrJ+rC5y9CWlSMUC1NutAP8bULmvtSt5E6eaK0A==
Received: from BYAPR06MB4296.namprd06.prod.outlook.com (2603:10b6:a03:10::20)
 by DM6PR06MB5051.namprd06.prod.outlook.com (2603:10b6:5:9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Thu, 30 Mar 2023 16:57:48 +0000
Received: from BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::c90b:a5f3:d41a:f8a3]) by BYAPR06MB4296.namprd06.prod.outlook.com
 ([fe80::c90b:a5f3:d41a:f8a3%3]) with mapi id 15.20.6178.041; Thu, 30 Mar 2023
 16:57:47 +0000
From:   "Mora, Jorge" <Jorge.Mora@netapp.com>
To:     "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>,
        Jeff Layton <jlayton@kernel.org>
CC:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: nfstest_delegation test can not stop
Thread-Topic: nfstest_delegation test can not stop
Thread-Index: AQHZVhyeEgfrYxW7RUGMwOMBUm8Jra77uYeAgAAsUpWAAstQgIASSXMAgAExjCmAAHj9AIAA9GF2
Date:   Thu, 30 Mar 2023 16:57:47 +0000
Message-ID: <BYAPR06MB429650D2AB13BDE2D5F19A77E18E9@BYAPR06MB4296.namprd06.prod.outlook.com>
References: <d5ed9eec-4bf4-8d70-0960-a30b2ef03938@fujitsu.com>
 <6ac6782b4d3efd8d76b1a590b446631a7f096752.camel@kernel.org>
 <BYAPR06MB4296C2EA5A613C7178DE2381E1BF9@BYAPR06MB4296.namprd06.prod.outlook.com>
 <d09ec9bc-a49a-81da-d746-87ba9a137833@fujitsu.com>
 <3218f65a-dcf6-32c3-5eed-32e2aa9735e5@fujitsu.com>
 <BYAPR06MB4296538CCA10288DC76C00B1E1899@BYAPR06MB4296.namprd06.prod.outlook.com>
 <c34c8f71-d048-6ed5-9268-7623ce083874@fujitsu.com>
In-Reply-To: <c34c8f71-d048-6ed5-9268-7623ce083874@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB4296:EE_|DM6PR06MB5051:EE_
x-ms-office365-filtering-correlation-id: 65b2ed03-3355-4115-519b-08db313fe3bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIfNfSvD5aOs8xy6nYXJQfXaoDt5YTB9rIGv7SEHfWisfoCpEOmieQ9akql35o+HDsvowMPlYsuQXCToZN2OJGDVvLIRk/zfSglM1yLlZKRrBpAwUDqfHzjmTc6c5Lszw38wUvJmQADmoMFFJdtzwoIwlxWQRP/RPyzJfajjXq7/LhMeSD9f/F7L75ofzDyqRjdR/160mEUY2SRpuqjLC0o8xEFS66nHI7bXk0PIfX+3+DpSkd/upFlkTiFDyBl2EPWGmuWFR7/YcfppWIn3Kp6/Uwp4tluGYn+7GIBUNS9Ub4xbvrOvLVeQCuOg3o2JiyboyceyIC4xJjkR75yKOEzKKO5IlSqsenudf98JrAZiBFPNMvkLhqpzRGYnH79RPbXV3gcTolJwahT17jSObzdVqjwoZi7P4EGvrIMqSFRv6SYMnWKKvh3THaY7ZlL9DooZjmVvaXERx61AyHgQZCkUWidoGPYr6DwqZPS8UQt8y9jN+hMXcvh3C1stmzQEPZDYE/uN87oyAcIavt8Q0J0HK+7tTXOg0FO3zJgdKdMXSlHW34nd02PiNc8PJhbPCU9ZRC33e24Z4Q6YihZBszVLyQ7eXSkv+LAxmYFEh0VzZrSpsZaZTjIrZG+PPzGp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4296.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(71200400001)(122000001)(7696005)(6506007)(53546011)(9686003)(26005)(110136005)(316002)(478600001)(38070700005)(186003)(91956017)(83380400001)(76116006)(66446008)(64756008)(8676002)(66946007)(66556008)(41300700001)(52536014)(4326008)(30864003)(5660300002)(38100700002)(2906002)(86362001)(8936002)(66476007)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bENhTGZVWEZON0lyYzhhOEpaNzdnVkZFYWJYamdoTTNiaGxmUnM1bCtP?=
 =?iso-2022-jp?B?R1RoNW9QMEZrd1drNnpEVnFHcmIzNlhBQWQ1OG44bCtTbDVrcXlPcW1P?=
 =?iso-2022-jp?B?NExISmUydGVBQmN5VUpGNklmZWMya3RsYXRaejI2YlU4TCtWQ1pyckcr?=
 =?iso-2022-jp?B?RmhlRHlXRU5rb1ZuOUxjNm9JbXJZVnBNd2RoZFVTMGppQU5oWmtNaFVY?=
 =?iso-2022-jp?B?YytJak1CbGdQc0hpc3p5aSsvNkZ1Q1IvV000Sm8wTXRhL2lyNTJNR1NO?=
 =?iso-2022-jp?B?WUx0N1A1dHZUeUhEWWQ3WlRFdExndnZTVWgzdEsreUtwY1pOTytLSDBo?=
 =?iso-2022-jp?B?dFBscEhVaFpxdTdkQWV5bkI5Y000TVVKdDMxb1Y3bTh1Y3VRbm1tSTVn?=
 =?iso-2022-jp?B?YmRGVHluZUtwaUlEVUZGK1h5ZGJoSnBmNFJsaG11ekpVeDZyMzgxbWUz?=
 =?iso-2022-jp?B?bEh4bFFQR3NpdDh0bGtqMG1JQWJHMXFPZXdIaFRiZmFVZnVnSUFFYzBT?=
 =?iso-2022-jp?B?YWJUR1k4Q2o5T296K2N1RGNlT0hBTkxIc3UwZ3htTVh4Q3hEcmdWZkxY?=
 =?iso-2022-jp?B?MTd1SXdDcnk2N0hFQm1zejc3ZS9vUHg2NzFkcTBSTnpubngwaUp0VlFh?=
 =?iso-2022-jp?B?WVFLUzBuRit5bXVvN3NIRExXbmI0RDBlWHdhUnlFbjkyMm5yZjA2dis5?=
 =?iso-2022-jp?B?MnFwVTNRRnpKMFE0aEZFRFN1Z0xkUTZ4c0F3UzRsUTc4Umh0TlMwRzN5?=
 =?iso-2022-jp?B?dk45TVltZE4ybnRPaldMTy81WjJ2SlVPUmxyZ0RNbTJsVkh1VTI0WWtl?=
 =?iso-2022-jp?B?VjM3bis3MTVybVNiVmo4akJxZlpLS3k3bzZpemN4bXRrUnY3RVRLZjQ5?=
 =?iso-2022-jp?B?aExTMkUrRWRmampZdkE1OFE5TXNWbmtQNThTYzN4cS9IdGg2S0dlZllH?=
 =?iso-2022-jp?B?TElmL1R6N1N3RTRBS055OTFBZjFUYkQwQnhEQkNDL0J2M2pXV1VBRzFM?=
 =?iso-2022-jp?B?d20wNnZIMEYvOURMdkx2b2pFaFpmRFdQL0t6ZTZOcTRweHlYaUZjVk5n?=
 =?iso-2022-jp?B?b0FXT1VuUkcxTE1mYjdFUGY3bFk3Yk5wNFJqT1VKc2dIeGZBbW04RHpJ?=
 =?iso-2022-jp?B?Y3lmMVBMMnNERU1DQ2o4eldvM3czVVk0SE1LaTBLN3QwSDRrV2lFVlVI?=
 =?iso-2022-jp?B?UndhdmdNbnMrRlE1NDg3K014eUtYN3E5RXk0a3JyckpLMHZqQXFzQVRy?=
 =?iso-2022-jp?B?bE91WlpOV3VlYzQ3R3hlbWR1SnVDMDNLYlNoOTc0STlnTDRSZHlNSVBu?=
 =?iso-2022-jp?B?cTRhb0srYmZhZFNwS1FENGYySXpzMlMycExHVEdRWkZWbk1rQXNrNDZU?=
 =?iso-2022-jp?B?UHBZUjhTWVc1SzZiQTdOUkxMZUNZQ0V1RW1SSmJ4QlBxUUVTcFFTdlhQ?=
 =?iso-2022-jp?B?QWtWU3pDTEdWSUFzTVZUVXQvN3dqOGxIUDBQNmUxbVAxQllLanNEN3Zy?=
 =?iso-2022-jp?B?NmpFSHNERXpFY2MwdXFpRUVtVzU2akxIWFFLOUMrQ1ZpbjE1bWxoUnVY?=
 =?iso-2022-jp?B?MXBERVBmMVFLMGFjU29PRElrbXRZTFNRRWhLT0RqOTZQOGZuMi92WTY3?=
 =?iso-2022-jp?B?SmlaZ3oyK0I1SDUrcVM1RzhBOU5kY3FjMXhqV2ljZmNkOG1oYzhja1pO?=
 =?iso-2022-jp?B?cDZhOGN0REdTWUd2dnk2R2g2dEorNGNwY0YzVlVRZUVqSFQ2T3NTSEpB?=
 =?iso-2022-jp?B?S3JPNGFJeGx5NHovZGViYmpQVHVEQ3FEdEtoS1lxdTR6YVBmMlNYVDVY?=
 =?iso-2022-jp?B?K2tRUm9TaEEwOFFtSlpMbDFUK3BUUlA5NFJiUTl3eW9lSGJiWUx4QWw1?=
 =?iso-2022-jp?B?VzdaTlhSRTBLejgyR1ErQks4Y1hIcVFqcmFQUWJQZTVTT0c2VUdDcy9r?=
 =?iso-2022-jp?B?cnNvQ0Y1TzE0OE0vY3pUVTcxS3hHcHRuc0pCaCtpN3dkQUluaXVXem15?=
 =?iso-2022-jp?B?VjJQeXpuclBTODR1UFJJT01jRkUrWlhoZHk5VUNWV3MwRFhEK0JXUXAz?=
 =?iso-2022-jp?B?dVdhSTc3cUVJTDlmbDMyWWd5bytObTU3RnYzNlRkckw1d0hNQlBuTU9U?=
 =?iso-2022-jp?B?ejdBMW80N1RmSUFYSXlkYzQyemoxeEdjcmJpSHFlSlduVTFlSVlUM0JE?=
 =?iso-2022-jp?B?NlczZmtUK05UenV4T0JFTktleURLZ3FxcWxWeHFFalBaZFpRbFc0bHIz?=
 =?iso-2022-jp?B?OWtPU241c09oNDlabFpIQVdHMHFJVkR0ND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4296.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b2ed03-3355-4115-519b-08db313fe3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 16:57:47.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfWs9UqruLaTdGhUbMBNzFYzDHwNiDHug2HsAltzgro8XJZfOOS7TAh6Iw3sTXZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5051
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,=0A=
=0A=
First of all, the --client option can be used successfully when the system =
in which you are running the test is able to capture the traffic for both c=
lients, e.g., when you are running VMware and both clients are VMs. If you =
are using real clients, tcpdump will only capture traffic for the local sys=
tem.=0A=
=0A=
./nfstest_delegation -h=0A=
  Test options:=0A=
    --runtest=3DRUNTEST=0A=
          Comma separated list of tests to run, if list starts with a '^' t=
hen=0A=
          all tests are run except the ones listed [default: 'all']=0A=
    --client=3DCLIENT=0A=
          Remote NFS client and options used for recall delegation tests.=
=0A=
          Clients are separated by a ',' and each client definition is a li=
st=0A=
          of arguments separated by a ':' given in the following order if=
=0A=
          positional arguments is used (see examples):=0A=
          clientname:server:export:nfsversion:port:proto:sec:mtpoint [defau=
lt:=0A=
          'nfsversion=3D3:proto=3Dtcp:port=3D2049']=0A=
    --client-nfsvers=3DCLIENT_NFSVERS=0A=
          Comma separated list of valid NFS versions to use in the --client=
=0A=
          option. An NFS version from this list, which is different than th=
at=0A=
          given by --nfsversion, is selected and included in the --client=
=0A=
          option [default: 4.0,4.1]=0A=
=0A=
The second client is a combination of --client and --client-nfsvers and the=
 default for --client is 'nfsversion=3D3:proto=3Dtcp:port=3D2049'. This mea=
ns that the mount for the second 'client' is on the main client with the fo=
llowing nfs mount options: 'nfsversion=3D4.0:proto=3Dtcp:port=3D2049' or 'n=
fsversion=3D4.1:proto=3Dtcp:port=3D2049' depending on the value for option =
--nfsversion. In you case, --nfsversion=3D4 (if you mean 4.0) the mount opt=
ions for the second client should be 'nfsversion=3D4.1...'. This way main m=
ount is 4.0 (holding delegation) and the second mount is 4.1 (recall delega=
tion) on the same system so the network traffic could be fully captured.=0A=
=0A=
Of course, if you specify --nfsversion=3D4, the client will mount either 4.=
2, 4.1 or 4.0 (in your logs: NFS version of mount point: 4.2). You need to =
explicitly specify the NFS version as 4.0, 4.1 or 4.2.=0A=
=0A=
The reason why the test is hanging is because the server is sending NFS4ERR=
_DELAY to COMMIT:=0A=
133 2023-03-30 07:46:22.533580 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0xfd10f3db SEQUENCE;PUTFH;OPEN;GETFH;ACCESS;GETATTR stid:1,0xe3=
7587e3 rd_deleg_stid:1,0xf1c0280d FH:0x634cb2d9=0A=
135 2023-03-30 07:46:22.533973 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0xfe10f3db SEQUENCE;PUTFH;OPEN;GETFH;ACCESS;GETATTR stid:1,0x49=
7c4f68  FH:0x62ab8136=0A=
136 2023-03-30 07:46:22.534191 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0xff10f3db SEQUENCE;PUTFH;LOCK       FH:0x62ab8136 WRITE_LT off=
:0 len:4096 open(stid:1,0x497c4f68, seqid:0) seqid:0=0A=
137 2023-03-30 07:46:22.534304 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0xff10f3db SEQUENCE;PUTFH;LOCK       stid:1,0xd4ab77d1=0A=
146 2023-03-30 07:46:22.659988 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0x0011f3db SEQUENCE;PUTFH;WRITE;GETATTR FH:0x62ab8136 stid:0,0x=
d4ab77d1 off:0 len:4096 UNSTABLE4=0A=
147 2023-03-30 07:46:22.660009 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0x0111f3db SEQUENCE;PUTFH;WRITE;GETATTR FH:0x62ab8136 stid:0,0x=
d4ab77d1 off:4096 len:4096 UNSTABLE4=0A=
...=0A=
191 2023-03-30 07:46:22.660695 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0x1011f3db SEQUENCE;PUTFH;COMMIT     FH:0x62ab8136 off:0 len:0=
=0A=
192 2023-03-30 07:46:22.672090 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0x1011f3db SEQUENCE;PUTFH;COMMIT     NFS4ERR_DELAY=0A=
194 2023-03-30 07:46:22.778177 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0x1111f3db SEQUENCE;PUTFH;COMMIT     FH:0x62ab8136 off:0 len:0=
=0A=
195 2023-03-30 07:46:22.779064 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0x1111f3db SEQUENCE;PUTFH;COMMIT     NFS4ERR_DELAY=0A=
197 2023-03-30 07:46:22.882100 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0x1211f3db SEQUENCE;PUTFH;COMMIT     FH:0x62ab8136 off:0 len:0=
=0A=
198 2023-03-30 07:46:22.882566 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0x1211f3db SEQUENCE;PUTFH;COMMIT     NFS4ERR_DELAY=0A=
200 2023-03-30 07:46:22.986157 192.168.122.108 -> 192.168.122.110 NFS   v4.=
2 call  xid:0x1311f3db SEQUENCE;PUTFH;COMMIT     FH:0x62ab8136 off:0 len:0=
=0A=
201 2023-03-30 07:46:22.986931 192.168.122.110 -> 192.168.122.108 NFS   v4.=
2 reply xid:0x1311f3db SEQUENCE;PUTFH;COMMIT     NFS4ERR_DELAY=0A=
=0A=
As Jeff mentioned earlier, Linux server does not grant write delegations. I=
 don't know what server are you using but the OPEN clearly shows it did not=
 grant a write delegation so this test should fail.=0A=
=0A=
Here is a sample run against a RHEL 8.6 server:=0A=
./nfstest_delegation -s 192.168.68.86 -e /export --nfsversion 4.0 -v all --=
createlog --keeptraces --rexeclog --tracepoints nfs,nfs4 recall22=0A=
=0A=
*** Recall WRITE delegation with RENAME (DST) with file lock=0A=
    TEST: Running test 'recall22'=0A=
    DBG5: 10:48:51.644258 - Sync all buffers to disk=0A=
    DBG2: 10:48:51.651724 - Unmount volume: /usr/bin/sudo umount -f /mnt/t=
=0A=
    DBG5: 10:48:51.684054 - Sync all buffers to disk=0A=
    DBG2: 10:48:51.685482 - Unmount volume: /usr/bin/sudo umount -f /mnt/t_=
01=0A=
    DBG2: 10:48:51.719133 - Enable trace points: /usr/bin/sudo sh -c "echo =
1 > /sys/kernel/debug/tracing/events/nfs/enable"=0A=
    DBG2: 10:48:51.761795 - Enable trace points: /usr/bin/sudo sh -c "echo =
1 > /sys/kernel/debug/tracing/events/nfs4/enable"=0A=
    DBG2: 10:48:51.805703 - Capturing trace points: /usr/bin/sudo sh -c "ca=
t /sys/kernel/debug/tracing/trace_pipe > /tmp/nfstest_delegation_20230330_1=
04846_001.out"=0A=
    DBG2: 10:48:51.808284 - Trace start: /usr/bin/sudo /usr/sbin/tcpdump -i=
 ens160 -n -B 196608 -s 0 -w /tmp/nfstest_delegation_20230330_104846_001.ca=
p host 192.168.68.87=0A=
    DBG2: 10:48:52.904843 - Mount volume: /usr/bin/sudo mount -o vers=3D4.0=
,proto=3Dtcp,sec=3Dsys,hard,rsize=3D4096,wsize=3D4096 192.168.68.86:/export=
 /mnt/t=0A=
    DBG5: 10:48:53.045345 - Get the actual NFS version of mount point: find=
mnt /mnt/t=0A=
    DBG6: 10:48:53.053811 -     NFS version of mount point: 4.0=0A=
    DBG2: 10:48:53.054069 - Mount volume: /usr/bin/sudo mount -o vers=3D4.1=
,proto=3Dtcp,sec=3Dsys,hard,rsize=3D4096,wsize=3D4096 192.168.68.86:/export=
 /mnt/t_01=0A=
    DBG5: 10:48:53.194449 - Get the actual NFS version of mount point: find=
mnt /mnt/t_01=0A=
    DBG6: 10:48:53.202076 -     NFS version of mount point: 4.1=0A=
    DBG4: 10:48:53.202297 - Open /mnt/t/nfstest_delegation_20230330_104846_=
f_001 so open owner sticks around=0A=
    DBG2: 10:48:53.207257 - Open file for WRITE [/mnt/t/nfstest_delegation_=
20230330_104846_f_002]=0A=
    PASS: Open file for WRITE should succeed=0A=
    DBG3: 10:48:53.208168 - Lock /mnt/t/nfstest_delegation_20230330_104846_=
f_002 (F_SETLK, F_WRLCK) start=3D0 len=3D4096=0A=
    PASS: Lock file with F_WRLCK should succeed=0A=
    DBG3: 10:48:53.209489 - Write file on client holding delegation [/mnt/t=
/nfstest_delegation_20230330_104846_f_002]=0A=
    PASS: Write file on client holding delegation should succeed=0A=
    DBG2: 10:48:53.310548 - Rename into the file (DST) from another client =
to recall delegation [nfstest_delegation_20230330_104846_f_003 -> nfstest_d=
elegation_20230330_104846_f_002]=0A=
    PASS: Rename into the file (DST) from another client should succeed=0A=
    DBG3: 10:48:53.320851 - Write file after conflicting operation [/mnt/t/=
nfstest_delegation_20230330_104846_f_002]=0A=
    PASS: Write file after conflicting operation may succeed=0A=
    DBG4: 10:48:53.447733 - Close /mnt/t/nfstest_delegation_20230330_104846=
_f_002=0A=
    DBG5: 10:48:53.450185 - Sync all buffers to disk=0A=
    DBG2: 10:48:53.457125 - Unmount volume: /usr/bin/sudo umount -f /mnt/t=
=0A=
    DBG5: 10:48:53.515896 - Sync all buffers to disk=0A=
    DBG2: 10:48:53.520120 - Unmount volume: /usr/bin/sudo umount -f /mnt/t_=
01=0A=
    DBG5: 10:48:55.580838 - Get all processes: ps -ef=0A=
    DBG5: 10:48:55.621321 - Stopping packet trace capture: /usr/bin/sudo /u=
sr/bin/kill -SIGINT 348494=0A=
    DBG5: 10:48:55.656126 - Stopping packet trace capture: /usr/bin/sudo /u=
sr/bin/kill -SIGINT 348489=0A=
    DBG2: 10:48:55.788319 - Disable trace points: /usr/bin/sudo sh -c "echo=
 0 > /sys/kernel/debug/tracing/events/nfs/enable"=0A=
    DBG2: 10:48:55.829243 - Disable trace points: /usr/bin/sudo sh -c "echo=
 0 > /sys/kernel/debug/tracing/events/nfs4/enable"=0A=
    DBG5: 10:48:55.875925 - Get all processes: ps -ef=0A=
    DBG2: 10:48:55.908161 - Stopping trace points capture: /usr/bin/sudo /u=
sr/bin/kill -SIGINT 348493=0A=
    DBG2: 10:48:55.939992 - Stopping trace points capture: /usr/bin/sudo /u=
sr/bin/kill -SIGINT 348492=0A=
    DBG2: 10:48:55.972241 - Stopping trace points capture: /usr/bin/sudo /u=
sr/bin/kill -SIGINT 348488=0A=
    DBG1: 10:48:56.104525 - trace_open [/tmp/nfstest_delegation_20230330_10=
4846_001.cap]=0A=
    PASS: OPEN should be sent=0A=
    PASS: OPEN should be sent with CLAIM_NULL=0A=
    PASS: OPEN should be sent with the name of the file to be opened=0A=
    PASS: OPEN should be sent with the filehandle of the directory=0A=
    FAIL: WRITE delegation should be granted=0A=
    TIME: 4.570563s=0A=
=0A=
I also added option --tracepoints to collect all nfs and nfs4 tracepoints. =
These are the files that are created:=0A=
ll /tmp/nfstest_delegation_20230330_104846*=0A=
-rw-r--r--. 1 tcpdump tcpdump 106776 Mar 30 10:48 /tmp/nfstest_delegation_2=
0230330_104846_001.cap (packet trace)=0A=
-rw-r--r--. 1 root    root     64218 Mar 30 10:48 /tmp/nfstest_delegation_2=
0230330_104846_001.out (tracepoints)=0A=
-rw-rw-r--. 1 mora    mora       317 Mar 30 10:48 /tmp/nfstest_delegation_2=
0230330_104846_01.log  (second 'client' process log file)=0A=
-rw-rw-r--. 1 mora    mora      9779 Mar 30 10:48 /tmp/nfstest_delegation_2=
0230330_104846.log     (main logfile)=0A=
=0A=
=0A=
--Jorge=0A=
=0A=
________________________________________=0A=
From: zhoujie2011@fujitsu.com <zhoujie2011@fujitsu.com>=0A=
Sent: Wednesday, March 29, 2023 7:42 PM=0A=
To: Mora, Jorge; Jeff Layton=0A=
Cc: linux-nfs=0A=
Subject: Re: nfstest_delegation test can not stop=0A=
=0A=
NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.=0A=
=0A=
=0A=
=0A=
=0A=
hi,=0A=
=0A=
> I am still waiting for all the files created for the run, not just the ou=
tput to the screen:=0A=
>=0A=
> /tmp/nfstest_delegation_20230317_170647*=0A=
The log file is attached.=0A=
=0A=
best regards,=0A=
=0A=
>=0A=
> ping=0A=
>=0A=
> On 3/17/23 16:58, zhoujie2011 wrote:=0A=
>> hi,=0A=
>>=0A=
>>   > Can you provide a log file for the run?=0A=
>> run following command and test result is attached.=0A=
>> ./nfstest_delegation --nfsversion=3D4 -e /nfsroot --server 192.168.122.1=
10=0A=
>> --client 192.168.122.109 --trcdelay 10 -v all --createlog --keeptraces=
=0A=
>> --rexeclog recall22 >nfstest-delegationv4-log_recall22 2>&1=0A=
>>=0A=
>> In server run "cat /etc/exports" output is following.=0A=
>> /nfsroot      *(rw,insecure,no_subtree_check,no_root_squash,fsid=3D1)=0A=
>>=0A=
>> best regards,=0A=
>>=0A=
>> On 3/15/23 22:28, Mora, Jorge wrote:=0A=
>>> Hello,=0A=
>>>=0A=
>>> Can you provide a log file for the run?=0A=
>>>=0A=
>>> ./nfstest_delegation -s 192.168.68.86 -e /export -v all --createlog=0A=
>>> --keeptraces --rexeclog recall22=0A=
>>>=0A=
>>> --Jorge=0A=
>>>=0A=
>>> *From: *Jeff Layton <jlayton@kernel.org>=0A=
>>> *Date: *Wednesday, March 15, 2023 at 5:40 AM=0A=
>>> *To: *zhoujie2011@fujitsu.com <zhoujie2011@fujitsu.com>, Mora, Jorge=0A=
>>> <Jorge.Mora@netapp.com>=0A=
>>> *Cc: *linux-nfs <linux-nfs@vger.kernel.org>=0A=
>>> *Subject: *Re: nfstest_delegation test can not stop=0A=
>>>=0A=
>>> NetApp Security WARNING: This is an external email. Do not click links=
=0A=
>>> or open attachments unless you recognize the sender and know the=0A=
>>> content is safe.=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>> On Tue, 2023-03-14 at 02:28 +0000, zhoujie2011@fujitsu.com wrote:=0A=
>>>   > hi,=0A=
>>>   >=0A=
>>>   > I run following test command and stuck at recall12 recall14 recall2=
0=0A=
>>>   > recall22 recall40 recall42 recall48 recall50.=0A=
>>>   >=0A=
>>>   > ./nfstest_delegation --nfsversion=3D4 -e /nfsroot --server <server =
ip>=0A=
>>>   > --client <client2 ip> --trcdelay 10=0A=
>>>   > ./nfstest_delegation --nfsversion=3D4.1 -e /nfsroot --server  <serv=
er=0A=
>>> ip>=0A=
>>>   > --client <client2 ip> --trcdelay 10=0A=
>>>   > ./nfstest_delegation --nfsversion=3D4.2 -e /nfsroot --server  <serv=
er=0A=
>>> ip>=0A=
>>>   > --client <client2 ip> --trcdelay 10=0A=
>>>   >=0A=
>>>   > recall12 recall14 recall20 recall22 recall40 recall42 recall48=0A=
>>> recall50=0A=
>>>   > tests write files after remove.=0A=
>>>   > After comment out above testcases result is:=0A=
>>>   > 646 tests (588 passed, 58 failed)=0A=
>>>   > FAIL: WRITE delegation should be granted=0A=
>>>   >=0A=
>>>   > run ./nfstest_dio have following messages.=0A=
>>>   > INFO: 16:19:51.455222 - WRITE delegations are not available --=0A=
>>> skipping=0A=
>>>   > tests expecting write delegations=0A=
>>>   >=0A=
>>>   > test OS: RHEL9.2 Nightly Build=0A=
>>>   > Why do these testcases can not stop?=0A=
>>>=0A=
>>> Are you asking why these testcases don't pass? If you're testing agains=
t=0A=
>>> the kernel's NFS server then it's because it does not (yet) support=0A=
>>> write delegations.=0A=
>>> --=0A=
>>> Jeff Layton <jlayton@kernel.org>=0A=
>>>=0A=
>>=0A=
>=0A=
> --=0A=
> ------------------------------------------------=0A=
> zhoujie=0A=
> Dept 1=0A=
> No. 6 Wenzhu Road,=0A=
> Nanjing, 210012, China=0A=
> TEL=1B$B!'=1B(B+86+25-86630566-8508=0A=
> FUJITSU INTERNAL=1B$B!'=1B(B7998-8508=0A=
> E-Mail=1B$B!'=1B(Bzhoujie2011@fujitsu.com=0A=
> ------------------------------------------------=0A=
=0A=
--=0A=
------------------------------------------------=0A=
zhoujie=0A=
Dept 1=0A=
No. 6 Wenzhu Road,=0A=
Nanjing, 210012, China=0A=
TEL=1B$B!'=1B(B+86+25-86630566-8508=0A=
FUJITSU INTERNAL=1B$B!'=1B(B7998-8508=0A=
E-Mail=1B$B!'=1B(Bzhoujie2011@fujitsu.com=0A=
------------------------------------------------=0A=
