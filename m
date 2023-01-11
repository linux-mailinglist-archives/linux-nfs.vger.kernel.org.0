Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6E665B58
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAKM10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 07:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjAKM1B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 07:27:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83435FAC
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673440011; bh=eW+++PC8Ryt+UKAjghGYOanEy86k4BC6KGmu+tIroSg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cqg5fUF2O3leFNl0lilUuPyS3BVhMPlyLJ2QRBzfI3sITAZfeiDLmoxv5G7lgm1KM
         NK6M6zJdQ5nJT9lFQ2YJg8Hhzel9ULttrXOzsMbK82FYlqQoJPtgIOdiC0QXIxnEVT
         UeMcWYRlHB/XJbAFf+kdieP82nlQgG2Bt+nNcz93E7fRSPjLgk9gw+7P/86j8G1TLn
         n/5g/tX+239S4HJuT6En6TI36pTFFQPL/34wo2JMLd1i1NMcPllE/mQUFrzzLgATFl
         twfI45ySNEkOIM05cdYcs4sdBEEwCzhlJNbW04t3Wbi7ySgz68iLmIKDfAZRQU458q
         occu3mhFmjoVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCOE-1pRlxX0CH6-00N7Ie; Wed, 11
 Jan 2023 13:26:51 +0100
Message-ID: <860d74c0a13c8c8330bed91b8085384399e14764.camel@gmx.de>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Mike Galbraith <efault@gmx.de>
To:     dai.ngo@oracle.com, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 13:26:50 +0100
In-Reply-To: <3b7b3462-0f15-58a7-b49c-eb563d20a8ec@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
         <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
         <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
         <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
         <3b7b3462-0f15-58a7-b49c-eb563d20a8ec@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0cqe1lrRpfUY2hREyoAGP3BePYEPllE+FUXZW2b5JlEMdkKQatg
 DcgYO+QPoSBKBbLp3RsaQRCW7dBy1oOK5v5ObgOAKkRwDt/RHrtIfWkhu/epWMnwBF7hi6O
 OwkwUb9HLPWH7t6+MHdMOf5YFVnDCw9hmkpEiItSQGt2gJLW7k8YxQVcBr5bhtjqHx+umm7
 Un7dOIaEBLXkMc/UoIu6w==
UI-OutboundReport: notjunk:1;M01:P0:SFPE1YhFTqI=;pSIwXX9ttwfOjprN0gB9PShgaNm
 2lHqMkkhcTsyfTRytJJ8UL0P9o3gH3fiy3GUq56uehlY6NINRRugsmwqFo6bhgG4Xw7+kcRNW
 osXdCwIzI+gnWeeZr6WpJkQgIUpRClLNtTcRLik506WiRj5HA1R4+J8C/A0j8xZYMHqJTJRx0
 /QOGn8WckqQcCANO1FOpqbQ0o0rbethqLZDVOAd7vVFXHgVZkKwU/y42S2dKMWA0XMSkx+XT+
 RGKVizwGvWRi1EdC4YU9Pbjtw7jAkcXycMTN1M0zKHzKiwHbWILLEiD6vrpCHJU0mpkFm/LXG
 wRJ0Ash1qlYkhM0ev+RyPHQb5JcYT4gSFpOrHKtuaHI6xySZ9xirZbIIyfTthX2dyIC35QxEb
 JlJEx/kuojg9Jixi1ggC61uiGLaK/blztSEl+ZbzSizHORZpUaOrVx5dP26JtbUE6MIIPiqst
 ceucDENS/cfRLWvMjHgivXRJ+YWq4Tch6nU9dUvoIrbda+0pErrpceA3L1P8BmS9vSyxb4A5u
 lK7SskZq8Ac9nqWcdM/2eooA1wvWRzAhXIEKa6PVemVicQOT1Stvi5RVb8ldwyTiuYY/kRDNF
 WGuAcZOHBWpqkAcxlZH+aHSpCp9vIzTCIkHs4ouaIcKu02jEKc8RDCj5PApQkOKVoJlMYcwOP
 hduX5N9NJ/3D2bqGmEkGGhICLecTQjNaGbYlbOwOmCEYyNRVhYv1AHFSyoWn2YYzbeYps+iaU
 AR70t22gRrsyW+4T+vaXvqVS82reprnOqQrjxigI/1DWlpmbCYosQu+32Q5YurRXuHf9DrMq9
 Dzpd4KTnTI+JbpnDMOLPaC16UMZ26eIirbYYeE3fzNlpQLtifrR2hY5toS4yLWTCQImSSlYYa
 6vEjq/Y6WVgL97a4XVGlFbUo4AAnWwCGGycTtW6f82zkngA8bzu28y37cakO9OWLf6hiSNVLj
 QcPHy1u32Tas9KW3wlAN4/HbYHE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 03:31 -0800, dai.ngo@oracle.com wrote:
>
> Can you try:
>
> crash7latest> nfsd_net_id
> nfsd_net_id =3D $2 =3D 9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <<=3D=3D=3D
> crash7latest> struct net.gen=C2=A0 init_net
> =C2=A0=C2=A0 gen =3D 0xffff97fc17d07d80
> crash7latest> x /10g 0xffff97fc17d07d80
> 0xffff97fc17d07d80:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x000000000000000d=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0000000000000000
> 0xffff97fc17d07d90:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0000000000000000=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff97fc0ac40060
> 0xffff97fc17d07da0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff994e7bf87600=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff98f731172a20
> 0xffff97fc17d07db0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff9844b05d9c00=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff9832a6a0add0
> 0xffff97fc17d07dc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff984a4470d740=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xffff984a93eb0600=C2=A0=C2=A0=C2=A0
> <<=3D=3D=3D entry for nfsd_net_id
> crash7latest> nfsd_net 0xffff984a93eb0600

(monkey see monkey do.. eep eep)

crash> nfsd_net_id
p: gdb request failed: p nfsd_net_id
crash> struct net.gen  init_net
  gen =3D 0xffff88810b7b8a00,
crash> x /10g 0xffff88810b7b8a00
0xffff88810b7b8a00:	0x0000000000000010	0x0000000000000000
0xffff88810b7b8a10:	0x0000000000000000	0xffff888101563380
0xffff88810b7b8a20:	0xffff888101ebd900	0xffff888101ebda00
0xffff88810b7b8a30:	0xffff888101f88b80	0xffff8881022056c0
0xffff88810b7b8a40:	0xffff888133b79e00	0xffff888110a2ca00
crash> nfsd_net 0xffff888110a2ca00
struct nfsd_net {
  cld_net =3D 0xffff888131c3c000,
  svc_expkey_cache =3D 0xffff888110a2cc00,
  svc_export_cache =3D 0xffff888110a2ce00,
  idtoname_cache =3D 0xffff8881061a8a00,
  nametoid_cache =3D 0xffff8881061a8c00,
  nfsd4_manager =3D {
    list =3D {
      next =3D 0xffff888141efa000,
      prev =3D 0xffff888133e6ea00
    },
    block_opens =3D false
  },
  grace_ended =3D false,
  boot_time =3D -131387065447864,
  nfsd_client_dir =3D 0xffff888110a2ca48,
  reclaim_str_hashtbl =3D 0xffff88810bed7408,
  reclaim_str_hashtbl_size =3D 1083333640,
  conf_id_hashtbl =3D 0x0,
  conf_name_tree =3D {
    rb_node =3D 0xffff888140925c00
  },
  unconf_id_hashtbl =3D 0xffff88810181c800,
  unconf_name_tree =3D {
    rb_node =3D 0x200000000
  },
  sessionid_hashtbl =3D 0x1,
  client_lru =3D {
    next =3D 0x0,
    prev =3D 0x0
  },
  close_lru =3D {
    next =3D 0xffff888110a2caa0,
    prev =3D 0xffff888110a2caa0
  },
  del_recall_lru =3D {
    next =3D 0x0,
    prev =3D 0xffffffffffffffff
  },
  blocked_locks_lru =3D {
    next =3D 0x0,
    prev =3D 0xffff88810a0e0f00
  },
  laundromat_work =3D {
    work =3D {
      data =3D {
        counter =3D 0
      },
      entry =3D {
        next =3D 0x0,
        prev =3D 0x0
      },
      func =3D 0x0
    },
    timer =3D {
      entry =3D {
        next =3D 0x0,
        pprev =3D 0x0
      },
      expires =3D 520729437059154371,
      function =3D 0x0,
      flags =3D 3526430787
    },
    wq =3D 0x24448948f6314540,
    cpu =3D 1133332496
  },
  client_lock =3D {
    {
      rlock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 344528932
            },
            {
              locked =3D 36 '$',
              pending =3D 24 '\030'
            },
            {
              locked_pending =3D 6180,
              tail =3D 5257
            }
          }
        }
      }
    }
  },
  blocked_locks_lock =3D {
    {
      rlock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 1820937252
            },
            {
              locked =3D 36 '$',
              pending =3D 76 'L'
            },
            {
              locked_pending =3D 19492,
              tail =3D 27785
            }
          }
        }
      }
    }
  },
  rec_file =3D 0x4808245c89483824,
  in_grace =3D 137,
  client_tracking_ops =3D 0xe8df8948005d8b,
  nfsd4_lease =3D -8266309238763028480,
  nfsd4_grace =3D 5476377146897729659,
  somebody_reclaimed =3D 139,
  track_reclaim_completes =3D 99,
  nr_reclaim_complete =3D {
    counter =3D -402096755
  },
  nfsd_net_up =3D false,
  lockd_up =3D false,
  writeverf_lock =3D {
    seqcount =3D {
      seqcount =3D {
        sequence =3D 140872013
      }
    },
    lock =3D {
      {
        rlock =3D {
          raw_lock =3D {
            {
              val =3D {
                counter =3D -387479220
              },
              {
                locked =3D 76 'L',
                pending =3D 137 '\211'
              },
              {
                locked_pending =3D 35148,
                tail =3D 59623
              }
            }
          }
        }
      }
    }
  },
  writeverf =3D "\000\000\000\000M\211,$",
  max_connections =3D 612141896,
  clientid_base =3D 59416,
  clientid_counter =3D 2336751616,
  clverifier_counter =3D 1275601988,
  nfsd_serv =3D 0x1024448b48185889,
  keep_active =3D 140740940,
  s2s_cp_cl_id =3D 1223133516,
  s2s_cp_stateids =3D {
    idr_rt =3D {
      xa_lock =3D {
        {
          rlock =3D {
            raw_lock =3D {
              {
                val =3D {
                  counter =3D 15205257
                },
                {
                  locked =3D 137 '\211',
                  pending =3D 3 '\003'
                },
                {
                  locked_pending =3D 905,
                  tail =3D 232
                }
              }
            }
          }
        }
      },
      xa_flags =3D 1224736768,
      xa_head =3D 0xf74f6854d241c89
    },
    idr_base =3D 276532552,
    idr_next =3D 232
  },
  s2s_cp_lock =3D {
    {
      rlock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 1933134848
            },
            {
              locked =3D 0 '\000',
              pending =3D 76 'L'
            },
            {
              locked_pending =3D 19456,
              tail =3D 29497
            }
          }
        }
      }
    }
  },
  nfsd_versions =3D 0x443924048b012404,
  nfsd4_minorversions =3D 0x2b4820f2424,
  drc_hashtbl =3D 0x8678d4d107b8d48,
  max_drc_entries =3D 232,
  maskbits =3D 1938508800,
  drc_hashsize =3D 4287187984,
  num_drc_entries =3D {
    counter =3D 232
  },
  counter =3D {{
      lock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 931745024
            },
            {
              locked =3D 0 '\000',
              pending =3D 77 'M'
            },
            {
              locked_pending =3D 19712,
              tail =3D 14217
            }
          }
        }
      },
      count =3D -8858645092202691189,
      list =3D {
        next =3D 0x24648b4cffffff43,
        prev =3D 0x246c8b4c24148b40
      },
      counters =3D 0xffffffffa0d0b540 <__this_module>
    }, {
      lock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 256
            },
            {
              locked =3D 0 '\000',
              pending =3D 1 '\001'
            },
            {
              locked_pending =3D 256,
              tail =3D 0
            }
          }
        }
      },
      count =3D -131387314532352,
      list =3D {
        next =3D 0x0,
        prev =3D 0xffffffffa0c949c0 <svc_udp_ops+1248>
      },
      counters =3D 0xffffffffa0c67f00 <ip_map_put>
    }},
  longest_chain =3D 2697366144,
  longest_chain_cachesize =3D 4294967295,
  nfsd_reply_cache_shrinker =3D {
    count_objects =3D 0xffffffffa0c67cd0 <ip_map_request>,
    scan_objects =3D 0xffffffffa0c68e40 <ip_map_parse>,
    batch =3D -1597606560,
    seeks =3D 0,
    flags =3D 0,
    list =3D {
      next =3D 0xffffffffa0c67350 <ip_map_alloc>,
      prev =3D 0x0
    },
    nr_deferred =3D 0xffffffffa0c68a00 <ip_map_match>
  },
  nfsd_ssc_lock =3D {
    {
      rlock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D -1597603936
            },
            {
              locked =3D 160 '\240',
              pending =3D 127 '\177'
            },
            {
              locked_pending =3D 32672,
              tail =3D 41158
            }
          }
        }
      }
    }
  },
  nfsd_ssc_mount_list =3D {
    next =3D 0xffffffffa0c68b10 <update>,
    prev =3D 0x49
  },
  nfsd_ssc_waitq =3D {
    lock =3D {
      {
        rlock =3D {
          raw_lock =3D {
            {
              val =3D {
                counter =3D -1596979232
              },
              {
                locked =3D 224 '\340',
                pending =3D 7 '\a'
              },
              {
                locked_pending =3D 2016,
                tail =3D 41168
              }
            }
          }
        }
      }
    },
    head =3D {
      next =3D 0xffff888110a2ce88,
      prev =3D 0xc2
    }
  },
  nfsd_name =3D "\001\000\000\000\000\000\000\000\200\t\021D\201\210\377\3=
77\200\t\021D\201\210\377\377\001\000\000\000\000\000\000\000\032\000\000\=
000\000\000\000\000\377\377\377\377\377\377\377\377\000\301\303\061\201\21=
0\377\377@$\234\203\377\377\377\377",
  fcache_disposal =3D 0x0,
  siphash_key =3D {
    key =3D {0, 0}
  },
  nfs4_client_count =3D {
    counter =3D 451
  },
  nfs4_max_clients =3D 122552490,
  nfsd_courtesy_clients =3D {
    counter =3D 0
  },
  nfsd_client_shrinker =3D {
    count_objects =3D 0xe8000002a0a3894c,
    scan_objects =3D 0x98b3894400000000,
    batch =3D 5483261796049485826,
    seeks =3D 15267721,
    flags =3D 1275068416,
    list =3D {
      next =3D 0x18247c8d4918658b,
      prev =3D 0x7c8b4900000000e8
    },
    nr_deferred =3D 0x4800000000e81824
  },
  nfsd_shrinker_work =3D {
    work =3D {
      data =3D {
        counter =3D -8554306017173128307
      },
      entry =3D {
        next =3D 0x894c00000000e8c4,
        prev =3D 0xf7894c00000268a3
      },
      func =3D 0x6d8b4800000000e8
    },
    timer =3D {
      entry =3D {
        next =3D 0x270bb8d4818,
        pprev =3D 0xbb8d4800000000e8
      },
      expires =3D 8118733695596102332,
      function =3D 0xe8000002,
      flags =3D 45908935
    },
    wq =3D 0x147424e783410000,
    cpu =3D 553616193
  }
}
crash>

